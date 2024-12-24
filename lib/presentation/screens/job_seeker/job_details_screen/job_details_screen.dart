import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/presentation/screens/employer/add_job_requirements_screen/add_job_requirement_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_home_tab/job_seeker_home_tab.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/widgets/custom_button.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});
  static const String routeName = 'JobDetailsScreen';

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Job job;

  @override
  Widget build(BuildContext context) {
    job = ModalRoute.of(context)!.settings.arguments as Job;
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
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.bookmark_outline,
                      color: AppColors.primary,
                      size: 30,
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
                    onPressed: () {},
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