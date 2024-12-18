import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/service/employer_services/employer_services.dart';
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
          FutureBuilder<List<Job>>(
            future: EmployerServices.getAllJobsFromThisEmployer(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(fontSize: 40),
                  ),
                );
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          JobApplicationsScreen.routeName,
                        );
                      },
                      child: CustomJobCard(
                        job: snapshot.data![index],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
