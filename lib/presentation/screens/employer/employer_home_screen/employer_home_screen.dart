import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/service/auth/auth_services.dart';

class EmployerHomeScreen extends StatelessWidget {
  const EmployerHomeScreen({super.key});
  static const String routeName = 'EmployerHomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Employer ${Employer.currentEmployer?.name}'),
            ElevatedButton(
              onPressed: () {
                AuthServices.logout(false, context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
