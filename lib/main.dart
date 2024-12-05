import 'package:flutter/material.dart';
import 'package:job_finder_app/presentation/screens/common/splash_screen/splash_screen.dart';
import 'package:job_finder_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/screens/employer/employer_profile_screen/employer_profile_screen.dart';
import 'presentation/screens/job_seeker/job_seeker_profile_screen/job_seeker_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const SplashScreen(),
    );
  }
}
