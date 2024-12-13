import 'package:flutter/material.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/home_tab/home_tab.dart';
import 'package:job_finder_app/presentation/screens/employer/job_applications_screen/job_applications_screen.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class JobsTab extends StatelessWidget {
  const JobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Jobs',
            style: AppStyle.titlesTextStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, JobApplicationsScreen.routeName);
                  },
                  child: const CustomJobCard()),
            ),
          ),
        ],
      ),
    );
  }
}
