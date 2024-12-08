import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/employer_home_screen.dart';
import 'package:job_finder_app/utils/dialog_utils.dart';

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
        Navigator.pushReplacementNamed(context, EmployerHomeScreen.routeName);
      }
    } catch (e) {
      if (context.mounted) {
        hideDialog(context);
      }

      print(e.toString());
    }
  }
}
