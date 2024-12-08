import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/data/service/employer_services/employer_services.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/dialog_utils.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';
import 'package:job_finder_app/utils/widgets/pick_image_widget.dart';

class EmployerProfileScreen extends StatefulWidget {
  const EmployerProfileScreen({super.key});
  // final UserCredential user;
  static const String routeName = 'EmployerProfileScreen';

  @override
  State<EmployerProfileScreen> createState() => _EmployerProfileScreenState();
}

class _EmployerProfileScreenState extends State<EmployerProfileScreen> {
  DateTime selectedDate = DateTime.now();
  bool isJobSeeker = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  File? imageFile;
  late UserCredential user;
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// This block is called after build it is only called only once
      emailController.text = user.user!.email!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as UserCredential;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Profile'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome, Employers!',
                    style: AppStyle.titlesTextStyle,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Upload your image or company logo',
                    style: AppStyle.bottomSheetTitle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  PickImageWidget(
                    imageFile: imageFile,
                    onPressed: () async {
                      imageFile = await CommonServices.pickImage();
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    type: TextInputType.name,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "name can not be empty";
                      }
                      return null;
                    },
                    label: 'Your Name or Company Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    // initialValue: widget.user.user!.email! ?? ' dhfd',
                    type: TextInputType.emailAddress,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "emails can not be empty";
                      }
                      if (!text.isValidEmail) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    label: 'Your Email or Company Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    type: TextInputType.name,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "address can not be empty";
                      }
                      return null;
                    },
                    label: 'Address',
                    controller: addressController,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Select company establishment date',
                    style: AppStyle.bottomSheetTitle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      selectedDate = await CommonServices.showMyDatePicker(
                        context,
                      );
                      setState(() {});
                    },
                    child: Text(
                      selectedDate.toFormattedDate,
                      style: AppStyle.normalGreyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    title: 'CONFIRM',
                    onPressed: () {
                      // Employer employer = Employer(
                      //   id: user.user!.uid,
                      //   name: nameController.text,
                      //   email: emailController.text,
                      //   address: addressController.text,
                      //   image: imageFile != null
                      //       ? await CommonServices.uploadImageToSupabase(
                      //           imageFile: imageFile)
                      //       : '',
                      //   companyEstablishmentDate: selectedDate,
                      //   isImageUploaded: imageFile != null ? true : false,
                      // );
                      EmployerServices.addEmployerToFireStore(
                        context,
                        formKey: formKey,
                        selectedDate: selectedDate,
                        imageFile: imageFile,
                        addressController: addressController,
                        emailController: emailController,
                        nameController: nameController,
                        id: user.user!.uid,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
