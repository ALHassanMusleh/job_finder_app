import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/service/employer_services/employer_services.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';

class AddJobRequirementScreen extends StatefulWidget {
  const AddJobRequirementScreen({super.key});

  static const String routeName = 'AddJobRequirementScreen';

  @override
  State<AddJobRequirementScreen> createState() =>
      _AddJobRequirementScreenState();
}

class _AddJobRequirementScreenState extends State<AddJobRequirementScreen> {
  TextEditingController requirementsController = TextEditingController();

  List<String> requirements = [];
  List<dynamic> arg = [];
  late Job job;
  File? imageFile;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// This block is called after build it is only called only once
      job = arg[0];
      imageFile = arg[1];
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    arg = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          job.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      CustomTextField(
                        label: 'Write a Requirement',
                        controller: requirementsController,
                        type: TextInputType.text,
                        validate: (text) {
                          if (text == null || text.isEmpty == true) {
                            return "name can not be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              title: 'Add',
                              isWhiteBg: true,
                              onPressed: () {
                                if(requirementsController.text == ''){
                                  return;
                                }
                                requirements.add(requirementsController.text);
                                setState(() {});
                                requirementsController.clear();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Requirement',
                    style: AppStyle.titlesTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: requirements.length,
                      itemBuilder: (context, index) => CustomRequirementsWidget(
                        text: requirements[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'Add new job',
                    onPressed: () {
                      EmployerServices.addNewJob(
                        context,
                        title: job.title,
                        salary: job.salary,
                        imageFile: imageFile,
                        locationSelected: job.location,
                        typeSelected: job.type,
                        statusSelected: job.status,
                        requirements: requirements,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRequirementsWidget extends StatelessWidget {
  const CustomRequirementsWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.tick_circle,
            color: AppColors.primary,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Text(
            text,
            maxLines: 3,
            style: AppStyle.labelStyle
                .copyWith(fontSize: 14, color: AppColors.black),
          )),
        ],
      ),
    );
  }
}
