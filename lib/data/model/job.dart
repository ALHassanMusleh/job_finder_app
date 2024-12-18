import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder_app/data/model/employer.dart';

class Job {
  late String id;
  late String title;
  late double salary;
  late String location;
  late String type;
  late String status;
  late List<String>? requirements;
  late String? image;
  late bool isImageUploaded;
  late DateTime createdAt;

  static const String collectionName = 'jobs';

  static CollectionReference get employerJobsCollection =>
      FirebaseFirestore.instance
          .collection(Employer.collectionName)
          .doc(Employer.currentEmployer!.id)
          .collection(Job.collectionName);

  Job({
    required this.id,
    required this.title,
    required this.salary,
    required this.location,
    required this.type,
    required this.status,
    required this.requirements,
    required this.image,
    required this.isImageUploaded,
    required this.createdAt,
  });

  Job.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    salary = json['salary'];
    location = json['location'];
    type = json['type'];
    status = json['status'];
    image = json['image'];
    isImageUploaded = json['isImageUploaded'];
    Timestamp timestamp = json['createdAt'];
    createdAt = timestamp.toDate();
    if (json['requirements'] != null) {
      requirements = [];
      json['requirements'].forEach((v) {
        requirements!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['salary'] = salary;
    map['location'] = location;
    map['type'] = type;
    map['status'] = status;
    map['image'] = image;
    map['isImageUploaded'] = isImageUploaded;
    map['createdAt'] = createdAt;
    map['requirements'] = requirements;
    // if (requirements != null) {
    //   map['requirements'] = requirements?.map((v) => v).toList();
    // }
    return map;
  }
}
