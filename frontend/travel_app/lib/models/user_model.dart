import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String token;
  String userId;
  String userEmail;
  List<String> userBookmarkedCities;

  User({
    required this.token,
    required this.userId,
    required this.userEmail,
    required this.userBookmarkedCities,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json["token"],
      userId: json["userId"],
      userEmail: json["userEmail"],
      userBookmarkedCities: List<String>.from(
        json["userBookmarkedCities"].map((id) => id.toString()),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "userId": userId,
        "userEmail": userEmail,
        "userBookmarkedCities":
            List<dynamic>.from(userBookmarkedCities.map((x) => x)),
      };
}
