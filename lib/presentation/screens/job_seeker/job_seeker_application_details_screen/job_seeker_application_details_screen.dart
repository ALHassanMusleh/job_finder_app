import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/application.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_applications_tab/job_seeker_applicatios_tab.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class JobSeekerApplicationDetailsScreen extends StatefulWidget {
  const JobSeekerApplicationDetailsScreen({super.key});
  static const String routeName = 'JobSeekerApplicationDetailsScreen';

  @override
  State<JobSeekerApplicationDetailsScreen> createState() =>
      _JobSeekerApplicationDetailsScreenState();
}

class _JobSeekerApplicationDetailsScreenState
    extends State<JobSeekerApplicationDetailsScreen> {
  List<dynamic> arg = [];
  late Job job;
  late Application application;
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     /// This block is called after build it is only called only once
  //     // application = arg[0] as Application;
  //     job = arg[1] as Job;
  //     setState(() {});
  //   });
  //   setState(() {});
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    arg = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    application = arg[0] as Application;
    job = arg[1] as Job;
    debugPrint('////');
    debugPrint(application.employerMessage);
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomJobAppliedAndDetailsToJobSeeker(
                      application: application, job: job),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Title',
                            style: AppStyle.titlesJobTextStyle,
                          ),
                          Text(
                            job.title,
                            style: AppStyle.titlesJobTextStyle
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Salary',
                            style: AppStyle.titlesJobTextStyle,
                          ),
                          Text(
                            '\$${job.salary}',
                            style: AppStyle.titlesJobTextStyle
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Type',
                            style: AppStyle.titlesJobTextStyle,
                          ),
                          Text(
                            job.type,
                            style: AppStyle.titlesJobTextStyle
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Location',
                            style: AppStyle.titlesJobTextStyle,
                          ),
                          Text(
                            job.location,
                            style: AppStyle.titlesJobTextStyle
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              application.employerMessage != null &&
                      application.employerMessage!.isNotEmpty
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
                          '''${application.employerMessage}''',
                          style: AppStyle.subTitlesTextStyle
                              .copyWith(color: AppColors.black),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
