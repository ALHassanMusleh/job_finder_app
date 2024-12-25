import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/app_user.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/employer_home_screen.dart';
import 'package:job_finder_app/utils/dialog_utils.dart';
import 'package:job_finder_app/utils/shared_pref_utils.dart';

abstract class EmployerServices {
  static Future<void> addEmployerToFireStore(BuildContext context,
      {required TextEditingController nameController,
      required TextEditingController emailController,
      required TextEditingController addressController,
      required GlobalKey<FormState> formKey,
      required File? imageFile,
      required DateTime selectedDate,
      required String id}) async {
    debugPrint('1');
    if (!formKey.currentState!.validate()) return;
    try {
      debugPrint('2');

      showLoading(context);
      CollectionReference employerCollection =
          FirebaseFirestore.instance.collection(Employer.collectionName);
      debugPrint('3');

      Employer employer = Employer(
        id: id,
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
        image: imageFile != null
            ? await CommonServices.uploadImageToSupabase(
                imageFile: imageFile,
              )
            : '',
        companyEstablishmentDate: selectedDate,
        isImageUploaded: imageFile != null ? true : false,
      );
      debugPrint('4');

      DocumentReference employerDoc = employerCollection.doc(employer.id);
      await employerDoc.set(employer.toJson());
      if (context.mounted) {
        Employer.currentEmployer = employer;

        SharedPrefUtils().saveUser(
          AppUser(
            id: employer.id,
            email: employer.email,
            name: employer.name,
            isJobSeeker: false,
          ),
        );
        Navigator.pushReplacementNamed(context, EmployerHomeScreen.routeName);
      }
    } catch (e) {
      if (context.mounted) {
        hideDialog(context);
      }

      debugPrint(e.toString());
    }
  }

  static Future<dynamic> getEmployerFromFireStore(String id) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection(Employer.collectionName);
    DocumentReference userDoc = userCollection.doc(id);
    DocumentSnapshot documentSnapShot = await userDoc.get();
    dynamic json =
        (documentSnapShot.data() == null ? null : Map<String, dynamic>);
    if (json != null) {
      json = documentSnapShot.data() as Map<String, dynamic>;
      return Employer.fromJson(json);
    } else {
      return null;
    }
  }

  static Future<void> addNewJob(
    BuildContext context, {
    required String title,
    required double salary,
    required File? imageFile,
    required String locationSelected,
    required String typeSelected,
    required String statusSelected,
    List<String>? requirements,
  }) async {
    try {
      debugPrint('1');

      showLoading(context);
      CollectionReference jobsCollection = FirebaseFirestore.instance
          .collection(Employer.collectionName)
          .doc(Employer.currentEmployer!.id)
          .collection(Job.collectionName);
      debugPrint('2');

      // Job employer = Employer(
      //   id: id,
      //   name: nameController.text,
      //   email: emailController.text,
      //   address: addressController.text,
      //   image: imageFile != null
      //       ? await CommonServices.uploadImageToSupabase(
      //     imageFile: imageFile,
      //   )
      //       : '',
      //   companyEstablishmentDate: selectedDate,
      //   isImageUploaded: imageFile != null ? true : false,
      // );
      DocumentReference jobDoc = jobsCollection.doc();

      Job job = Job(
        id: jobDoc.id,
        title: title,
        salary: salary,
        location: locationSelected,
        type: typeSelected,
        status: statusSelected,
        image: imageFile != null
            ? await CommonServices.uploadImageToSupabase(
                imageFile: imageFile,
              )
            : '',
        isImageUploaded: imageFile != null ? true : false,
        requirements: requirements,
        createdAt: DateTime.now(),
        employerName: Employer.currentEmployer!.name,
        employerId: Employer.currentEmployer!.id,
      );
      debugPrint('3');

      await jobDoc.set(job.toJson());

      if (context.mounted) {
        hideDialog(context);
        showMessage(
          context,
          title: 'Success',
          body: 'Added new job',
          posButtonTitle: 'ok',
        );
      }
    } catch (e) {
      if (context.mounted) {
        hideDialog(context);
      }

      print(e.toString());
    }
  }

  static Future<List<Job>> getAllJobsFromThisEmployer() async {
    List<Job> jobsList = [];
    // CollectionReference jobsCollection = FirebaseFirestore.instance
    //     .collection(Employer.collectionName)
    //     .doc(Employer.currentEmployer!.id)
    //     .collection(Job.collectionName);
    QuerySnapshot querySnapShot = (await Job.employerJobsCollection
        .orderBy('createdAt', descending: true)
        .get());
    List<QueryDocumentSnapshot> documents = querySnapShot.docs;
    // print(documents.length);
    jobsList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return Job.fromJson(json);
    }).toList();
    print(jobsList);

    // jobsList = jobsList.where((todo) =>
    // // todo.date.year == selectedDateCalender.year &&
    // // todo.date.month == selectedDateCalender.month &&
    // // todo.date.day == selectedDateCalender.day,
    // selectedDateCalender.isSameDate(todo.date)).toList(); // extension

    // jobsList.sort((job1, job2) {
    //   return job1.createdAt.compareTo(job2.createdAt);
    // });

    return jobsList;
  }

  static Future<List<Job>> getRecentJobsFromThisEmployer() async {
    List<Job> jobsList = [];
    QuerySnapshot querySnapShot = (await Job.employerJobsCollection
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

  static void updateEmployerProfile(
    BuildContext context, {
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController addressController,
    required GlobalKey<FormState> formKey,
    required File? imageFile,
    required DateTime selectedDate,
  }) async {
    if (!formKey.currentState!.validate()) return;
    try {
      showLoading(context);
      Employer employer = Employer(
        id: Employer.currentEmployer!.id,
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
        // image: Employer.currentEmployer!.isImageUploaded
        //     ? Employer.currentEmployer?.image
        //     : imageFile != null
        //         ? await CommonServices.uploadImageToSupabase(
        //             imageFile: imageFile,
        //           )
        //         : '',
        image: imageFile == null
            ? Employer.currentEmployer!.isImageUploaded
                ? Employer.currentEmployer?.image
                : ''
            : imageFile != null
                ? await CommonServices.uploadImageToSupabase(
                    imageFile: imageFile,
                  )
                : '',
        companyEstablishmentDate: selectedDate,
        isImageUploaded: imageFile == null
            ? Employer.currentEmployer!.isImageUploaded
                ? true
                : false
            : imageFile != null
                ? true
                : false,
      );

      await Employer.employerCollection.update(employer.toJson());

      if (context.mounted) {
        Employer.currentEmployer = employer;
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
