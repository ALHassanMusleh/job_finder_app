import 'package:cloud_firestore/cloud_firestore.dart';

class JobSeeker {
  late String id;
  late String name;
  late String email;
  late String occupation;
  late String image;
  late DateTime dateOfBirth;
  late String address;
  late bool isImageUploaded;
  static const String collectionName = 'jobSeekers';

  JobSeeker({
    required this.id,
    required this.name,
    required this.email,
    required this.occupation,
    required this.image,
    required this.dateOfBirth,
    required this.address,
    required this.isImageUploaded,
  });

  JobSeeker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    occupation = json['occupation'];
    image = json['image'];
    Timestamp timestamp = json['dateOfBirth'];
    dateOfBirth = timestamp.toDate();
    address = json['address'];
    isImageUploaded = json['isImageUploaded'];
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'occupation': occupation,
      'image': image,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'isImageUploaded': isImageUploaded,
    };
  }
}
