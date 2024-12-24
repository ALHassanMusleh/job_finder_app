import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/app_user.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/job_seeker_home_screen.dart';
import 'package:job_finder_app/utils/dialog_utils.dart';
import 'package:job_finder_app/utils/shared_pref_utils.dart';

abstract class JobSeekerServices {
  static Future<void> addJobSeekerToFireStore(
    BuildContext context, {
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController occupationController,
    required TextEditingController addressController,
    required GlobalKey<FormState> formKey,
    File? imageFile,
    required DateTime selectedDate,
    required String id,
  }) async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      CollectionReference jobSeekerCollection =
          FirebaseFirestore.instance.collection(JobSeeker.collectionName);
      JobSeeker jobSeeker = JobSeeker(
        id: id,
        name: nameController.text,
        email: emailController.text,
        occupation: occupationController.text,
        image: imageFile != null
            ? await CommonServices.uploadImageToSupabase(imageFile: imageFile)
            : '',
        dateOfBirth: selectedDate,
        address: addressController.text,
        isImageUploaded: imageFile != null ? true : false,
      );
      DocumentReference jobSeekerDoc = jobSeekerCollection.doc(jobSeeker.id);
      await jobSeekerDoc.set(jobSeeker.toJson());
      if (context.mounted) {
        JobSeeker.currentJobSeeker = jobSeeker;

        SharedPrefUtils().saveUser(
          AppUser(
            id: jobSeeker.id,
            email: jobSeeker.email,
            name: jobSeeker.name,
            isJobSeeker: true,
          ),
        );
        Navigator.pushReplacementNamed(context, JobSeekerHomeScreen.routeName);
      }
    } catch (e) {
      if (context.mounted) {
        hideDialog(context);
      }

      print(e.toString());
    }
  }

  static Future<dynamic> getJobSeekerFromFireStore(String id) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(JobSeeker.collectionName);
    DocumentReference userDoc = userCollection.doc(id);
    DocumentSnapshot documentSnapShot = await userDoc.get();
    dynamic json =
        (documentSnapShot.data() == null ? null : Map<String, dynamic>);
    if (json != null) {
      json = documentSnapShot.data() as Map<String, dynamic>;
      return JobSeeker.fromJson(json);
    } else {
      return null;
    }
  }

  static Future<List<Job>> getRecentJobs() async {
    List<Job> jobsList = [];
    QuerySnapshot querySnapShot = (await Job.jobsCollection
        .orderBy('createdAt', descending: true)
        .limit(3)
        .get());
    List<QueryDocumentSnapshot> documents = querySnapShot.docs;
    jobsList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return Job.fromJson(json);
    }).toList();

    print(jobsList);

    return jobsList;
  }

  // static Future<List<Employer>> getTopEmployer() async {
  //   final employersSnapshot = await FirebaseFirestore.instance.collection(Employer.collectionName).get();
  //   print(employersSnapshot.size);
  //   List<Employer> employers = [];
  //
  //   for (var employerDoc in employersSnapshot.docs) {
  //     // Count jobs for each employer
  //     final jobsSnapshot = await FirebaseFirestore.instance
  //         .collection(Employer.collectionName)
  //         .doc(employerDoc.id)
  //         .collection(Job.collectionName)
  //         .get();
  //
  //     try {
  //       if (jobsSnapshot.size >= 1) {
  //         print('//////////////////////////////');
  //
  //         print(jobsSnapshot.size);
  //         print('//////////////////////////////');
  //         List<QueryDocumentSnapshot> documents = jobsSnapshot.docs;
  //         employers = documents.map((doc) {
  //           Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
  //           return Employer.fromJson(json);
  //         }).toList();
  //         print(employers);
  //
  //       }
  //     }
  //     catch(e){
  //       print(e.toString());
  //     }
  //
  //   }
  //   return employers;
  // }

  static Future<List<Employer>> getTopEmployers() async {
    final firestore = FirebaseFirestore.instance;

    // Get all employers
    final employersSnapshot =
        await firestore.collection(Employer.collectionName).get();

    List<Employer> topEmployers = [];

    for (var employerDoc in employersSnapshot.docs) {
      // Count documents in the Jobs subcollection for each employer
      final jobsSnapshot = await firestore
          .collection(Employer.collectionName)
          .doc(employerDoc.id)
          .collection(Job.collectionName)
          .get();

      int jobCount = jobsSnapshot.size;

      if (jobCount >= 1) {
        // Create an Employer instance from the document
        final employer = Employer.fromJson({
          ...employerDoc.data(), // Spread document data
        });

        topEmployers.add(employer);
      }
    }

    // Return the list of top employers
    return topEmployers;
  }

  static Future<List<Employer>> getAllEmployer() async {
    List<Employer> employersList = [];
    // CollectionReference jobsCollection = FirebaseFirestore.instance
    //     .collection(Employer.collectionName)
    //     .doc(Employer.currentEmployer!.id)
    //     .collection(Job.collectionName);
    QuerySnapshot querySnapShot = (await FirebaseFirestore.instance
        .collection(Employer.collectionName)
        .get());
    List<QueryDocumentSnapshot> documents = querySnapShot.docs;
    // print(documents.length);
    employersList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return Employer.fromJson(json);
    }).toList();
    print(employersList);

    // jobsList = jobsList.where((todo) =>
    // // todo.date.year == selectedDateCalender.year &&
    // // todo.date.month == selectedDateCalender.month &&
    // // todo.date.day == selectedDateCalender.day,
    // selectedDateCalender.isSameDate(todo.date)).toList(); // extension

    // jobsList.sort((job1, job2) {
    //   return job1.createdAt.compareTo(job2.createdAt);
    // });

    return employersList;
  }

  static Future<List<Job>> getAllJobsFromEmployer(
      {required String employerId}) async {
    List<Job> jobsList = [];
    QuerySnapshot querySnapShot = (await FirebaseFirestore.instance
        .collection(Employer.collectionName)
        .doc(employerId)
        .collection(Job.collectionName)
        .orderBy('createdAt', descending: true)
        .get());
    List<QueryDocumentSnapshot> documents = querySnapShot.docs;
    jobsList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return Job.fromJson(json);
    }).toList();

    print(jobsList);

    return jobsList;
  }

  static void updateJobSeekerProfile(
    BuildContext context, {
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController occupationController,
    required TextEditingController addressController,
    required GlobalKey<FormState> formKey,
    File? imageFile,
    required DateTime selectedDate,
  }) async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      JobSeeker jobSeeker = JobSeeker(
        id: JobSeeker.currentJobSeeker!.id,
        name: nameController.text,
        email: emailController.text,
        occupation: occupationController.text,
        dateOfBirth: selectedDate,
        address: addressController.text,
        image: imageFile == null
            ? JobSeeker.currentJobSeeker!.isImageUploaded
                ? JobSeeker.currentJobSeeker?.image
                : ''
            : imageFile != null
                ? await CommonServices.uploadImageToSupabase(
                    imageFile: imageFile,
                  )
                : '',
        isImageUploaded: imageFile == null
            ? JobSeeker.currentJobSeeker!.isImageUploaded
                ? true
                : false
            : imageFile != null
                ? true
                : false,
      );

      await JobSeeker.jobSeekerCollection.update(jobSeeker.toJson());

      if (context.mounted) {
        JobSeeker.currentJobSeeker = jobSeeker;
        hideDialog(context);
        showMessage(
          context,
          title: 'Success',
          body: 'Edited Succefully Profile',
          posButtonTitle: 'ok',
        );
      }
    } catch (e) {
      if (context.mounted) {
        hideDialog(context);
        showMessage(context, title: e.toString());
      }
    }
  }
}
