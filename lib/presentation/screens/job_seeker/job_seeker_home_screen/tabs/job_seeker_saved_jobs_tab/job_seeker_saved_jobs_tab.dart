import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/provider/employer/jobs_provider.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_home_tab/job_seeker_home_tab.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:provider/provider.dart';

class JobSeekerSavedJobsTab extends StatelessWidget {
  JobSeekerSavedJobsTab({super.key});

  late SavedJobsProvider savedJobsProvider;
  @override
  Widget build(BuildContext context) {
    savedJobsProvider = Provider.of(context);
    if (savedJobsProvider.savedJobsList.isNotEmpty) {
      return ListView.builder(
        itemCount: savedJobsProvider.savedJobsList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   JobApplicationsScreen.routeName,
            // );
          },
          child: CustomJobCardForJobSeeker(
            job: savedJobsProvider.savedJobsList[index],
          ),
        ),
      );
    } else {
      return const Center(
        child: Text(
          'Not found jobs saved',
          style: AppStyle.titlesTextStyle,
        ),
      );
    }
  }
}
