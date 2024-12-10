import 'dart:convert';

class AppUser {
  String? id;
  String? name;
  String? email;
  bool? isJobSeeker;

  AppUser({
    this.id,
    this.name,
    this.email,
    this.isJobSeeker,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    isJobSeeker = json['isJobSeeker'];
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isJobSeeker': isJobSeeker,
    };
  }
}
