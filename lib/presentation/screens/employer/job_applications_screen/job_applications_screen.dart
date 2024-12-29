import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/application_job_result.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/service/employer_services/employer_services.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/home_tab/home_tab.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class JobApplicationsScreen extends StatelessWidget {
  JobApplicationsScreen({super.key});
  static const String routeName = 'JobApplicationsScreen';

  late Job job;
  @override
  Widget build(BuildContext context) {
    job = ModalRoute.of(context)!.settings.arguments as Job;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Application For job',
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
            CustomJobCard(
              job: job,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'All Applications',
              style: AppStyle.titlesTextStyle,
            ),
            FutureBuilder<ApplicationJobResult>(
              future: EmployerServices.getApplicationsForJobInEmployer(job.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // print(snapshot.error.toString());
                  // throw Exception(snapshot.error.toString());
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: const TextStyle(fontSize: 40),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data!.applications!.length,
                      itemBuilder: (context, index) =>
                          CustomJobAppliedAndDetailsToEmployer(
                        application: snapshot.data!.applications![index],
                        job: job,
                        jobSeeker: snapshot.data!.jobSeeker![index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
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
      ),
    );
  }
}
