import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';
import 'package:job_finder_app/utils/widgets/pick_image_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  DateTime selectedDate = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  File? imageFile;

  @override
  void initState() {
    nameController.text = Employer.currentEmployer!.name;
    addressController.text = Employer.currentEmployer!.address;
    emailController.text = Employer.currentEmployer!.email;
    selectedDate = Employer.currentEmployer!.companyEstablishmentDate;
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
                  'Upload your image or company logo',
                  style: AppStyle.bottomSheetTitle.copyWith(
                    fontSize: 16,
                  ),
                ),
                PickImageWidget(
                  isImageUploaded: Employer.currentEmployer!.isImageUploaded,
                  imagePath: Employer.currentEmployer!.image,
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
                  title: 'EDIT',
                  onPressed: () {},
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
