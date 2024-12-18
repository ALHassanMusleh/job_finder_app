import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job.dart';

// class JobsProvider extends ChangeNotifier {
//   List<Job> jobsList = [];
//   Future<List<Job>> getAllJobsFromThisEmployer() async {
//     CollectionReference jobsCollection = FirebaseFirestore.instance
//         .collection(Employer.collectionName)
//         .doc(Employer.currentEmployer!.id)
//         .collection(Job.collectionName);
//     QuerySnapshot querySnapShot = await jobsCollection.get();
//     List<QueryDocumentSnapshot> documents = querySnapShot.docs;
//     // print(documents.length);
//     jobsList = documents.map((doc) {
//       Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
//       return Job.fromJson(json);
//     }).toList();
//     print(jobsList);
//
//     // jobsList = jobsList.where((todo) =>
//     // // todo.date.year == selectedDateCalender.year &&
//     // // todo.date.month == selectedDateCalender.month &&
//     // // todo.date.day == selectedDateCalender.day,
//     // selectedDateCalender.isSameDate(todo.date)).toList(); // extension
//
//     jobsList.sort((job1, job2) {
//       return job1.createdAt.compareTo(job2.createdAt);
//     });
//
//     notifyListeners();
//     return jobsList;
//   }
// }
