import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_finder_app/data/model/job_seeker.dart';
import 'package:job_finder_app/presentation/screens/common/Auth/login_screen/login_screen.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_applications_tab/job_seeker_applicatios_tab.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_chats_tab/job_seeker_chats_tab.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_home_tab/job_seeker_home_tab.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_profile_tab/job_seeker_profile_tab.dart';
import 'package:job_finder_app/presentation/screens/job_seeker/job_seeker_home_screen/tabs/job_seeker_saved_jobs_tab/job_seeker_saved_jobs_tab.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';
import 'package:job_finder_app/utils/shared_pref_utils.dart';

class JobSeekerHomeScreen extends StatefulWidget {
  const JobSeekerHomeScreen({super.key});
  static const String routeName = 'JobSeekerHomeScreen';

  @override
  State<JobSeekerHomeScreen> createState() => _JobSeekerHomeScreenState();
}

class _JobSeekerHomeScreenState extends State<JobSeekerHomeScreen> {
  int selectedIndex = 0;

  List<Widget> tabs = [
    JobSeekerHomeTab(),
    const JobSeekerApplicationsTab(),
    JobSeekerSavedJobsTab(),
    const JobSeekerChatsTab(),
    const JobSeekerProfileTab(),
  ];

  List<String> titleTabs = const [
    'Home',
    'Applications',
    'Saved',
    'Chat',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleTabs[selectedIndex],
          style: AppStyle.titlesTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              SharedPrefUtils.removeData();
              JobSeeker.currentJobSeeker = null;
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            icon: const Icon(Iconsax.logout),
            color: AppColors.black,
          ),
        ],
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() => NavigationBar(
        onDestinationSelected: (index) {
          selectedIndex = index;
          setState(() {});
        },
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Iconsax.menu_board), label: 'Applications'),
          NavigationDestination(icon: Icon(Iconsax.bookmark), label: 'Saved'),
          NavigationDestination(icon: Icon(Iconsax.message), label: 'Chats'),
          NavigationDestination(
              icon: Icon(Iconsax.profile_circle), label: 'Profile'),
        ],
      );
}
