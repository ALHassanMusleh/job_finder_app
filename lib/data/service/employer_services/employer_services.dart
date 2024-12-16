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
    print(1);
    if (!formKey.currentState!.validate()) return;
    try {
      print(2);

      showLoading(context);
      CollectionReference employerCollection =
          FirebaseFirestore.instance.collection(Employer.collectionName);
      print(3);

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
      print(4);

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

      print(e.toString());
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
      print(2);

      showLoading(context);
      CollectionReference jobsCollection = FirebaseFirestore.instance
          .collection(Employer.collectionName)
          .doc(Employer.currentEmployer!.id)
          .collection(Job.collectionName);
      print(3);

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
      );
      print(4);

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
}
