import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/presentation/screens/employer/add_job_requirements_screen/add_job_requirement_screen.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/extensions.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';
import 'package:job_finder_app/utils/widgets/pick_image_widget.dart';

class AddJobTab extends StatefulWidget {
  const AddJobTab({super.key});

  @override
  State<AddJobTab> createState() => _AddJobTabState();
}

class _AddJobTabState extends State<AddJobTab> {
  GlobalKey<FormState> formKey = GlobalKey();
  File? imageFile;
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  String locationSelected = 'OnSite';
  String typeSelected = 'Full Time';
  String statusSelected = 'Active';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Add New Job',
                  style: AppStyle.titlesTextStyle,
                ),
                const SizedBox(height: 15),
                PickImageWidget(
                  imageFile: imageFile,
                  onPressed: () async {
                    imageFile = await CommonServices.pickImage();
                    setState(() {});
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  type: TextInputType.name,
                  validate: (text) {
                    if (text == null || text.isEmpty == true) {
                      return "name can not be empty";
                    }
                    return null;
                  },
                  label: 'Job title',
                  controller: jobTitleController,
                ),
                const SizedBox(height: 15),
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
                  label: 'Job salary',
                  controller: salaryController,
                ),
                const SizedBox(height: 15),
                Text(
                  'Location',
                  style: AppStyle.bottomSheetTitle.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                CustomDropDown(
                  item1: 'OnSite',
                  value1: 'OnSite',
                  item2: 'Remotely',
                  value2: 'Remotely',
                  onChanged: (value) {
                    locationSelected = value ?? 'OnSite';
                    setState(() {});
                  },
                  valueSelected: locationSelected,
                ),
                const SizedBox(height: 15),
                Text(
                  'Type of job',
                  style: AppStyle.bottomSheetTitle.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                CustomDropDown(
                  item1: 'Full Time',
                  value1: 'Full Time',
                  item2: 'Part Time',
                  value2: 'Part Time',
                  onChanged: (value) {
                    typeSelected = value ?? 'Full Time';
                    setState(() {});
                  },
                  valueSelected: typeSelected,
                ),
                const SizedBox(height: 15),
                Text(
                  'Status',
                  style: AppStyle.bottomSheetTitle.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                CustomDropDown(
                  item1: 'Active',
                  value1: 'Active',
                  item2: 'Inactive',
                  value2: 'Inactive',
                  onChanged: (value) {
                    statusSelected = value ?? 'Active';
                    setState(() {});
                  },
                  valueSelected: statusSelected,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  title: 'NEXT',
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AddJobRequirementScreen.routeName,
                    );
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

  // Widget buildLanguageDropdown() => CustomDropDown();
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.value1,
    required this.value2,
    required this.item1,
    required this.item2,
    this.onChanged,
    required this.valueSelected,
  });
  final String value1;
  final String item1;
  final String value2;
  final String item2;
  final void Function(String?)? onChanged;
  final String valueSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: AppStyle.containerDecoration,
      child: DropdownButton(
        // value: selectedLanguage,
        // value: provider.locale,
        value: valueSelected,
        onChanged: onChanged,
        isExpanded: true, //Expanded drop down as with
        padding: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(10),
        dropdownColor: AppColors.white,
        style: AppStyle.subTitlesTextStyle,
        items: [
          DropdownMenuItem(
            value: value1,
            child: Text(item1),
          ),
          DropdownMenuItem(
            value: value2,
            child: Text(item2),
          ),
        ],
      ),
    );
  }
}
