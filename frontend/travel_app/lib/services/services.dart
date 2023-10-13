import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/models/destinations_model.dart';
import 'package:travel_app/models/user_model.dart';

class DestinationServices {
  String api = "localhost:3000/";
  static String endpoint = 'http://192.168.100.8:3000';
  // String endpoint = 'http://localhost:3000';
  static Client? client = Client();
  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static String? serverMessage;

  static Future<List<Destinations>> fetchDestinations() async {
    try {
      var response = await client!.get(Uri.parse("$endpoint/destinations"));
      log('Response:  $response');
      return destinationsFromJson(response.body);
    } on Exception catch (err) {
      log('Error: $err');
      throw Exception('Failed to fetch all places');
    }
  }

  static Future<User> bookmarkOrUnbookmarkDestination(
      String destinationId) async {
    var userId = prefs!.getString('userId');
    log('userId: $userId');
    log("destinationId: $destinationId");

    // Make a PUT request to the backend to update the user's bookmarks
    final response = await client!.put(
      Uri.parse('$endpoint/users/$userId/bookmarks'),
      body: jsonEncode({
        "userId": userId,
        "destinationId": destinationId,
      }),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      log("Response: ${response.statusCode}");
      return userFromJson(response.body);
    }
  }

  static Future signUp(
      {required String fullName,
      required String email,
      required String password}) async {
    log('UserName: $fullName, email: $email, password $password');

    var body = {
      "userName": fullName,
      "email": email,
      "password": password,
      "bookmarkedCities": []
    };

    var response = await client!.post(
      Uri.parse("$endpoint/signUp"),
      body: jsonEncode(body),
      headers: requestHeaders,
    );

    try {
      if (response.statusCode == 201) {
        log('Response: ${response.body}');
        serverMessage = "User successfully created";
        prefs!.setString("token", response.body);
        return userFromJson(response.body);
      } else {
        log('Response:  ${response.body}');
        serverMessage = "Email already exits";
      }
    } catch (err) {
      log("Error: $err");
      // serverMessage = err.toString();
    }
  }

  static Future login({required String email, required String password}) async {
    log('email: $email, password: $password');

    var body = {
      "email": email,
      "password": password,
    };

    var response = await client!.post(
      Uri.parse("$endpoint/login"),
      body: jsonEncode(body),
      headers: requestHeaders,
    );
    try {
      if (response.statusCode == 200) {
        prefs!.setString("token", response.body);

        return userFromJson(response.body);
      } else {
        log('Response: ${response.statusCode}, ${response.body}');
        return "Opps Something went wrong: ${response.statusCode}";
      }
    } catch (err) {
      log('Error: $err');
      rethrow;
    }
  }

  static Future<bool> logout() async {
    await client!.get(Uri.parse("$endpoint/logout"));
    prefs!.setString("token", "");
    return true;
  }
}
