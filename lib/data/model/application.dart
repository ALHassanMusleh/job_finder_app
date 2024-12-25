import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job.dart';

class Application {
  late String id;
  late String jobSeekerId;
  late String? jobSeekerMessage;
  late String? employerMessage;
  late String resume;
  late String jobId;
  late String status;
  static const String collectionName = 'application';

  Application({
    required this.id,
    required this.jobSeekerId,
    required this.jobSeekerMessage,
    required this.employerMessage,
    required this.resume,
    required this.jobId,
    required this.status,
  });

  Application.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobSeekerId = json['jobSeekerId'];
    jobSeekerMessage = json['jobSeekerMessage'];
    employerMessage = json['employerMessage'];
    resume = json['resume'];
    jobId = json['jobId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobSeekerId': jobSeekerId,
      'jobSeekerMessage': jobSeekerMessage,
      'employerMessage': employerMessage,
      'resume': resume,
      'jobId': jobId,
      'status': status,
    };
  }
}
