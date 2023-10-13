// To parse this JSON data, do
//
//     final destinations = destinationsFromJson(jsonString);

import 'dart:convert';

List<Destinations> destinationsFromJson(String str) => List<Destinations>.from(
    json.decode(str).map((x) => Destinations.fromJson(x)));

String destinationsToJson(List<Destinations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Destinations {
  String id;
  String cityName;
  String country;
  bool? bookmarkStatus;
  List<String> attractions;
  String cityInfo;
  List<String> cityImages;
  String? rating;
  bool? destinationBookmarkStatus;

  Destinations({
    required this.id,
    required this.cityName,
    required this.country,
    this.bookmarkStatus,
    required this.attractions,
    required this.cityInfo,
    required this.cityImages,
    this.rating,
    this.destinationBookmarkStatus,
  });

  Destinations copyWith({
    String? id,
    String? cityName,
    String? country,
    bool? bookmarkStatus,
    List<String>? attractions,
    String? cityInfo,
    List<String>? cityImages,
    String? rating,
    bool? destinationBookmarkStatus,
  }) =>
      Destinations(
        id: id ?? this.id,
        cityName: cityName ?? this.cityName,
        country: country ?? this.country,
        bookmarkStatus: bookmarkStatus ?? this.bookmarkStatus,
        attractions: attractions ?? this.attractions,
        cityInfo: cityInfo ?? this.cityInfo,
        cityImages: cityImages ?? this.cityImages,
        rating: rating ?? this.rating,
        destinationBookmarkStatus:
            destinationBookmarkStatus ?? this.destinationBookmarkStatus,
      );

  factory Destinations.fromJson(Map<String, dynamic> json) => Destinations(
        id: json["_id"],
        cityName: json["cityName"],
        country: json["country"],
        bookmarkStatus: json["bookmarkStatus"],
        attractions: List<String>.from(json["attractions"].map((x) => x)),
        cityInfo: json["cityInfo"],
        cityImages: List<String>.from(json["cityImages"].map((x) => x)),
        rating: json["rating"],
        destinationBookmarkStatus: json["bookmark_status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cityName": cityName,
        "country": country,
        "bookmarkStatus": bookmarkStatus,
        "attractions": List<dynamic>.from(attractions.map((x) => x)),
        "cityInfo": cityInfo,
        "cityImages": List<dynamic>.from(cityImages.map((x) => x)),
        "rating": rating,
        "bookmark_status": destinationBookmarkStatus,
      };
}
