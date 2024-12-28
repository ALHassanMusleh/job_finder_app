import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Application {
  late String id;
  late String jobSeekerId;
  late String employerId;
  String? jobSeekerMessage;
  String? employerMessage;
  late String resume;
  late String jobId;
  late String status;
  static const String collectionName = 'application';

  static Query<Map<String, dynamic>> get applicationCollection =>
      FirebaseFirestore.instance.collectionGroup(Application.collectionName);

  Application({
    required this.id,
    required this.jobSeekerId,
    required this.employerId,
    required this.jobSeekerMessage,
    required this.employerMessage,
    required this.resume,
    required this.jobId,
    required this.status,
  });

  Application.fromJson(Map<String, dynamic> json) {
    debugPrint('Start parsing Application');

    debugPrint('Parsing id');
    id = json['id'];

    debugPrint('Parsing jobSeekerId');
    jobSeekerId = json['jobSeekerId'];

    debugPrint('Parsing employerId');
    employerId = json['employerId'];

    debugPrint('Parsing jobSeekerMessage');
    jobSeekerMessage = json['jobSeekerMessage'];

    debugPrint('Parsing employerMessage');
    employerMessage = json['employerMessage'];

    debugPrint('Parsing resume');
    resume = json['resume'];

    debugPrint('Parsing jobId');
    jobId = json['jobId'];

    debugPrint('Parsing status');
    status = json['status'];

    debugPrint('Finished parsing Application');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobSeekerId': jobSeekerId,
      'employerId': employerId,
      'jobSeekerMessage': jobSeekerMessage,
      'employerMessage': employerMessage,
      'resume': resume,
      'jobId': jobId,
      'status': status,
    };
  }
}
