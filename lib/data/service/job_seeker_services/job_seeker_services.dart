import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/employer_home_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/job_seeker_home_screen.dart';
import 'package:job_finder_app/utils/dialog_utils.dart';

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
        Navigator.pushReplacementNamed(context, JobSeekerHomeScreen.routeName);
      }
    } catch (e) {
      if (context.mounted) {
        hideDialog(context);
      }

      print(e.toString());
    }
  }
}
