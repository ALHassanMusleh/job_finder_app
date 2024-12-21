import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_home_tab/job_seeker_home_tab.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/jobs_list_from_employer_screen/job_list_from_employer_screen.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class EmployerListScreen extends StatelessWidget {
  const EmployerListScreen({super.key});
  static const String routeName = 'EmployersListScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Employers'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All Employers',
              style: AppStyle.titlesTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Employer>>(
              future: JobSeekerServices.getAllEmployer(),
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
                            JobListFromEmployerScreen.routeName,
                            arguments: snapshot.data![index],
                          );
                        },
                        child: CustomEmployerCard(
                          employer: snapshot.data![index],
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
      ),
    );
  }
}
