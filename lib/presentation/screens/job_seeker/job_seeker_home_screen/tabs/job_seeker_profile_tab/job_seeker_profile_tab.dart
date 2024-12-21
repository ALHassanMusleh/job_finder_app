import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';
import 'package:job_finder_app/utils/widgets/pick_image_widget.dart';

class JobSeekerProfileTab extends StatefulWidget {
  const JobSeekerProfileTab({super.key});

  @override
  State<JobSeekerProfileTab> createState() => _JobSeekerProfileTabState();
}

class _JobSeekerProfileTabState extends State<JobSeekerProfileTab> {
  DateTime selectedDate = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  File? imageFile;

  @override
  void initState() {
    nameController.text = JobSeeker.currentJobSeeker!.name;
    addressController.text = JobSeeker.currentJobSeeker!.address;
    emailController.text = JobSeeker.currentJobSeeker!.email;
    occupationController.text = JobSeeker.currentJobSeeker!.occupation;
    selectedDate = JobSeeker.currentJobSeeker!.dateOfBirth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  'Profile Employers!',
                  style: AppStyle.titlesTextStyle,
                ),
                const SizedBox(height: 15),
                Text(
                  'Upload your image or company logo ${JobSeeker.currentJobSeeker?.name}',
                  style: AppStyle.bottomSheetTitle.copyWith(
                    fontSize: 16,
                  ),
                ),
                PickImageWidget(
                  isImageUploaded: JobSeeker.currentJobSeeker!.isImageUploaded,
                  imagePath: JobSeeker.currentJobSeeker!.image,
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
                  title: 'EDIT',
                  onPressed: () {
                    JobSeekerServices.updateJobSeekerProfile(context,
                        nameController: nameController,
                        emailController: emailController,
                        occupationController: occupationController,
                        addressController: addressController,
                        formKey: formKey,
                        selectedDate: selectedDate);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
