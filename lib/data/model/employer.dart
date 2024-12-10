import 'package:cloud_firestore/cloud_firestore.dart';

class Employer {
  late String id;
  late String name;
  late String email;
  late String address;
  late String? image;
  late bool isImageUploaded;
  late DateTime companyEstablishmentDate;

  static Employer? currentEmployer;

  static const String collectionName = 'employer';

  Employer({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.image,
    required this.companyEstablishmentDate,
    required this.isImageUploaded,
  });

  Employer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    image = json['image'];
    Timestamp timestamp = json['companyEstablishmentDate'];
    companyEstablishmentDate = timestamp.toDate();
    isImageUploaded = json['isImageUploaded'];
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'image': image,
      'companyEstablishmentDate': companyEstablishmentDate,
      'isImageUploaded': isImageUploaded,
    };
  }
}
