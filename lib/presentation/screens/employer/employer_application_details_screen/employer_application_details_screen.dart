import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/application.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/data/service/employer_services/employer_services.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/home_tab/home_tab.dart';
import 'package:job_finder_app/presentation/screens/employer/pdf_view_screen/pdf_view_screen.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:job_finder_app/utils/widgets/custom_text_field.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class EmployerApplicationDetailsScreen extends StatefulWidget {
  const EmployerApplicationDetailsScreen({super.key});
  static const String routeName = 'EmployerApplicationDetailsScreen';

  @override
  State<EmployerApplicationDetailsScreen> createState() =>
      _EmployerApplicationDetailsScreenState();
}

class _EmployerApplicationDetailsScreenState
    extends State<EmployerApplicationDetailsScreen> {
  List<dynamic> arg = [];

  List<String> status = [
    'Pending',
    'Reject',
    'Accept',
    'Schedule to Interview',
  ];
  late Job job;
  String? valueSelected;

  late Application application;
  late JobSeeker jobSeeker;
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    arg = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    application = arg[0] as Application;
    jobSeeker = arg[1] as JobSeeker;
    job = arg[2] as Job;
    valueSelected = application.status;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Application  Details',
          style: AppStyle.titlesTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomJobAppliedCardToEmployer(
                      job: job,
                      jobSeeker: jobSeeker,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomButton(
                    //         title: 'See Resume',
                    //         onPressed: () async {
                    //           final file = await CommonServices.loadNetwork(
                    //               application.resume);
                    //           openPDF(context, file);
                    //         },
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 8,
                    //     ),
                    //     Expanded(
                    //       child: CustomButton(
                    //         title: 'Download Resume',
                    //         onPressed: () {
                    //           openFile(application.resume,
                    //               'Resume for ${jobSeeker.name}');
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: 'See Resume',
                            onPressed: () {
                              openFile(application.resume,
                                  'Resume for ${jobSeeker.name}');
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    application.jobSeekerMessage != null &&
                            application.jobSeekerMessage!.isNotEmpty
                        ? Column(
                            children: [
                              Text(
                                'Employer Message',
                                style: AppStyle.subTitlesTextStyle
                                    .copyWith(color: AppColors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '''${application.jobSeekerMessage}''',
                                style: AppStyle.subTitlesTextStyle
                                    .copyWith(color: AppColors.black),
                              ),
                            ],
                          )
                        : Container(),
                    Text(
                      'Status for application',
                      style: AppStyle.subTitlesTextStyle
                          .copyWith(color: AppColors.black),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: AppStyle.containerDecoration,
                      child: DropdownButton(
                        // value: selectedLanguage,
                        // value: provider.locale,
                        value: valueSelected ?? status[0],
                        onChanged: (value) {
                          valueSelected = value;
                          setState(() {});
                        },
                        isExpanded: true, //Expanded drop down as with
                        padding: const EdgeInsets.all(8),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: AppColors.white,
                        style: AppStyle.subTitlesTextStyle,
                        items: [
                          DropdownMenuItem(
                            value: status[0],
                            child: Text(status[0]),
                          ),
                          DropdownMenuItem(
                            value: status[1],
                            child: Text(status[1]),
                          ),
                          DropdownMenuItem(
                            value: status[2],
                            child: Text(status[2]),
                          ),
                          DropdownMenuItem(
                            value: status[3],
                            child: Text(status[3]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                    title: 'Send To Applicants',
                    onPressed: () {
                      EmployerServices.updateApplicationForJobSeekerInEmployer(
                        context,
                        employerId: application.employerId,
                        jobId: application.jobId,
                        applicationId: application.id,
                        status: valueSelected ?? status[0],
                        employerMessage: messageController.text,
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

  void openPDF(context, File file) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PdfViewScreen(file: file)));
  }

  void openFile(String url, String fileName) async {
    final file = await downloadFile(url, fileName);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final aapStorage = await getApplicationDocumentsDirectory();
    File file = File('${aapStorage.path}/${name}');
    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: Duration(seconds: 0),
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
