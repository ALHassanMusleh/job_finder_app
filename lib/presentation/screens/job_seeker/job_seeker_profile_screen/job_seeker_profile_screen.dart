import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/auth/auth_services.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';
import 'package:job_finder_app/utils/widgets/pick_image_widget.dart';

class JobSeekerProfileScreen extends StatefulWidget {
  const JobSeekerProfileScreen({super.key});
  static const String routeName = 'JobSeekerProfileScreen';

  @override
  State<JobSeekerProfileScreen> createState() => _JobSeekerProfileScreenState();
}

class _JobSeekerProfileScreenState extends State<JobSeekerProfileScreen> {
  DateTime selectedDate = DateTime.now();
  bool isJobSeeker = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  File? imageFile;
  late UserCredential user;

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
        title: const Text('Job Seeker Profile'),
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
                    'Welcome, Job seekers!',
                    style: AppStyle.titlesTextStyle,
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
                    label: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    // initialValue: 'hassan@gamil.com',
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
                    label: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    type: TextInputType.name,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "Occupation can not be empty";
                      }
                      return null;
                    },
                    label: 'Occupation',
                    controller: occupationController,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    type: TextInputType.name,
                    validate: (text) {
                      if (text == null || text.isEmpty == true) {
                        return "Address can not be empty";
                      }
                      return null;
                    },
                    label: 'Address',
                    controller: addressController,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Select date of birth',
                    style: AppStyle.bottomSheetTitle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      selectedDate =
                          await CommonServices.showMyDatePicker(context);
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
                      // JobSeeker jobSeeker = JobSeeker(
                      //   id: user.user!.uid,
                      //   name: nameController.text,
                      //   email: emailController.text,
                      //   occupation: occupationController.text,
                      //   image: imageFile != null
                      //       ? await CommonServices.uploadImageToSupabase(
                      //           imageFile: imageFile)
                      //       : '',
                      //   dateOfBirth: selectedDate,
                      //   address: addressController.text,
                      //   isImageUploaded: imageFile != null ? true : false,
                      // );
                      // JobSeekerServices.addJobSeekerToFireStore(context,
                      //     jobSeeker: jobSeeker, formKey: formKey);
                      JobSeekerServices.addJobSeekerToFireStore(
                        context,
                        addressController: addressController,
                        emailController: emailController,
                        id: user.user!.uid,
                        nameController: nameController,
                        occupationController: occupationController,
                        selectedDate: selectedDate,
                        imageFile: imageFile,
                        formKey: formKey,
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
