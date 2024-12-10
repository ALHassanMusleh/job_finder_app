import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/auth/auth_services.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';

class JobSeekerHomeScreen extends StatelessWidget {
  const JobSeekerHomeScreen({super.key});
  static const String routeName = 'JobSeekerHomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Job Seeker ${JobSeeker.currentJobSeeker!.name}'),
            ElevatedButton(
              onPressed: () {
                AuthServices.logout(true, context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
