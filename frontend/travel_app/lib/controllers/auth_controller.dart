import 'package:email_validator/email_validator.dart';

import '../main.dart';
import '../services/services.dart';

class AuthController {
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address.';
    } else if (!EmailValidator.validate(email)) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    } else if (password.length < 6) {
      return 'Password should be at least 8 characters';
    } else {
      return null;
    }
  }

  Future<dynamic> userlogin(String email, String password) async {
    var response = await DestinationServices.login(
      email: email,
      password: password,
    );

    prefs!.setString("userId", response.userId);
    prefs!.setString("token", response.token);
    prefs!.setString("email", "response.userEmail");
    prefs!.setStringList("bookmarks", response.userBookmarkedCities ?? []);
    return response;
  }
}
