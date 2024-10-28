class UserProfile {
  String id;
  String name;
  String imageUrl;

  UserProfile({required this.id, required this.name, required this.imageUrl});

  // Convert a UserProfile into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  // Create a UserProfile from a Map
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
