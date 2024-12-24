import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_home_tab/job_seeker_home_tab.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class JobListFromEmployerScreen extends StatefulWidget {
  const JobListFromEmployerScreen({super.key});
  static const String routeName = 'JobListFromEmployerScreen';

  @override
  State<JobListFromEmployerScreen> createState() =>
      _JobListFromEmployerScreenState();
}

class _JobListFromEmployerScreenState extends State<JobListFromEmployerScreen> {
  late Employer employer;

  @override
  Widget build(BuildContext context) {
    employer = ModalRoute.of(context)!.settings.arguments as Employer;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jobs',
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
            CustomEmployerCard(
              employer: employer,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'All Jobs',
              style: AppStyle.titlesTextStyle,
            ),
            Expanded(
              child: FutureBuilder<List<Job>>(
                future: JobSeekerServices.getAllJobsFromEmployer(
                    employerId: employer.id),
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
                            // Navigator.pushNamed(
                            //   context,
                            //   JobListFromEmployerScreen.routeName,
                            //   arguments: snapshot.data![index],
                            // );
                          },
                          child: CustomJobCardForJobSeeker(
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
            ),
          ],
        ),
      ),
    );
  }
}
