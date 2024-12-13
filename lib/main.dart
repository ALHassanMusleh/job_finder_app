import 'package:flutter/material.dart';
import 'package:job_finder_app/data/model/app_user.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/data/service/employer_services/employer_services.dart';
import 'package:job_finder_app/data/service/job_seeker_services/job_seeker_services.dart';
import 'package:job_finder_app/presentation/screens/common/Auth/login_screen/login_screen.dart';
import 'package:job_finder_app/presentation/screens/common/Auth/register_screen/register_screen.dart';
import 'package:job_finder_app/presentation/screens/common/splash_screen/splash_screen.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/employer_home_screen.dart';
import 'package:job_finder_app/presentation/screens/employer/job_applications_screen/job_applications_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/job_seeker_home_screen.dart';
import 'package:job_finder_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_finder_app/utils/shared_pref_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'presentation/screens/employer/employer_profile_screen/employer_profile_screen.dart';
import 'presentation/screens/job_seeker/job_seeker_profile_screen/job_seeker_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://cbttwduqtwplzxnjmtmk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNidHR3ZHVxdHdwbHp4bmptdG1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM1MDYyNTUsImV4cCI6MjA0OTA4MjI1NX0.q_4a1ekuCOEqNuDmxvL1NVO8rP2v4fKWQGZXHNsutCk',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPrefUtils sharedPrefUtils = SharedPrefUtils();
  AppUser? isFindUser = await sharedPrefUtils.getUser();
  if (isFindUser != null) {
    if (isFindUser.isJobSeeker!) {
      JobSeeker.currentJobSeeker =
          await JobSeekerServices.getJobSeekerFromFireStore(isFindUser.id!);
    } else {
      Employer.currentEmployer =
          await EmployerServices.getEmployerFromFireStore(isFindUser.id!);
    }
  }
  runApp(MyApp(
    isFindUser: isFindUser,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFindUser});
  final AppUser? isFindUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        EmployerProfileScreen.routeName: (context) =>
            const EmployerProfileScreen(),
        JobSeekerProfileScreen.routeName: (context) =>
            const JobSeekerProfileScreen(),
        JobSeekerHomeScreen.routeName: (context) => const JobSeekerHomeScreen(),
        EmployerHomeScreen.routeName: (context) => const EmployerHomeScreen(),
        JobApplicationsScreen.routeName: (context) =>
            const JobApplicationsScreen(),
      },
      initialRoute: isFindUser != null
          ? isFindUser!.isJobSeeker!
              ? JobSeekerHomeScreen.routeName
              : EmployerHomeScreen.routeName
          : SplashScreen.routeName,
    );
  }
}
