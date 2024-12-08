import 'package:flutter/material.dart';

class JobSeekerHomeScreen extends StatelessWidget {
  const JobSeekerHomeScreen({super.key});
  static const String routeName = 'JobSeekerHomeScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome Job Seeker'),
      ),
    );
  }
}
