import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/application.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_home_tab/job_seeker_home_tab.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';

import '../../../../utils/widgets/custom_text_field.dart';

class ApplyForJobScreen extends StatefulWidget {
  const ApplyForJobScreen({super.key});
  static const String routeName = 'ApplyForJobScreen';

  @override
  State<ApplyForJobScreen> createState() => _ApplyForJobScreenState();
}

class _ApplyForJobScreenState extends State<ApplyForJobScreen> {
  late Job job;
  TextEditingController messageController = TextEditingController();
  File? file;
  String? fileName;
  double? size;
  @override
  Widget build(BuildContext context) {
    job = ModalRoute.of(context)!.settings.arguments as Job;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apply for this job',
          style: AppStyle.titlesJobTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomJobCardForJobSeeker(
                      job: job,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Upload Resume',
                      style: AppStyle.titlesTextStyle
                          .copyWith(color: AppColors.primary),
                    ),
                    const Text(
                      'Upload Your Resume to apply job (only pdf file)',
                      style: AppStyle.labelStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (file != null)
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 3,
                        child: Container(
                          decoration: AppStyle.containerDecoration,
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                                size: 40,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      fileName ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      size!.toStringAsFixed(2) + ' KB',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          file = await pickFile();
                          setState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                          ),
                          decoration: AppStyle.containerDecoration,
                          child: const Column(
                            children: [
                              Icon(
                                Icons.cloud_upload_rounded,
                                size: 35,
                                color: AppColors.primary,
                              ),
                              Text(
                                'Upload File',
                                style: AppStyle.labelStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      label: 'Write a message (Optional)',
                      controller: messageController,
                      type: TextInputType.text,
                      validate: (text) {
                        if (text == null || text.isEmpty == true) {
                          return "name can not be empty";
                        }
                        return null;
                      },
                      line: 8,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: 'Confirm',
                    onPressed: () {
                      JobSeekerServices.applyForAnyJob(
                        context,
                        file: file,
                        job: job,
                        jobSeekerMessage: messageController.text,
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

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );

    if (result != null) {
      // Get the file name
      fileName = result.files.single.name;

      // Get the file size (in KB )
      size = result.files.single.size / 1024;

      File file = File(result.files.single.path!);
      return file;
      print('success');
    } else {
      // User canceled the picker
      return null;
    }
  }
}
