import 'dart:convert';

class Location {
  int id;
  String name;
  Coordinates coordinates;
  String description;

  Location({required this.id, required this.name, required this.coordinates, required this.description});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      description: json['description'],
    );
  }

  static List<Location> fromJsonList(String jsonString) {
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((json) => Location.fromJson(json)).toList();
  }
}

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
