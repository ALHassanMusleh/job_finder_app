import 'package:flutter/material.dart';

class EmployerHomeScreen extends StatelessWidget {
  const EmployerHomeScreen({super.key});
  static const String routeName = 'EmployerHomeScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome Employer'),
      ),
    );
  }
}
