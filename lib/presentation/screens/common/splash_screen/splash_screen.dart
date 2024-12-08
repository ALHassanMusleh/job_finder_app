import 'package:flutter/material.dart';
import 'package:job_finder_app/presentation/screens/common/Auth/login_screen/login_screen.dart';
import 'package:job_finder_app/utils/app_assets.dart';
import 'package:job_finder_app/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          AppAssets.splash,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
