import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/provider/employer/jobs_provider.dart';
import 'package:job_finder_app/data/service/common_services/common_services.dart';
import 'package:job_finder_app/presentation/screens/employer/add_job_requirements_screen/add_job_requirement_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/apply_for_job_screen/apply_for_job_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_home_tab/job_seeker_home_tab.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});
  static const String routeName = 'JobDetailsScreen';

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Job job;
  File? file;
  late SavedJobsProvider savedJobsProvider;
  @override
  Widget build(BuildContext context) {
    job = ModalRoute.of(context)!.settings.arguments as Job;
    savedJobsProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Details',
          style: AppStyle.titlesTextStyle,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomJobCardForJobSeeker(
                    job: job,
                    isShow: false,
                  ),
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
                  const Text(
                    'Requirements',
                    style: AppStyle.titlesJobTextStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: job.requirements!.length,
                      itemBuilder: (context, index) => CustomRequirementsWidget(
                        text: job.requirements![index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      savedJobsProvider.toggleWatchlist(job);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: savedJobsProvider.moviesIsBooked(job)
                          ? const Icon(
                              Icons.bookmark,
                              color: AppColors.primary,
                            )
                          : const Icon(
                              Icons.bookmark_outline,
                              color: AppColors.primary,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 7,
                  child: CustomButton(
                    title: 'Apply for this job',
                    onPressed: () {
                      Navigator.pushNamed(context, ApplyForJobScreen.routeName,
                          arguments: job);
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
