import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_finder_app/data/model/employer.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/add_job_tab/add_job_tab.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/chats_tab/chats_tab.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/home_tab/home_tab.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/jobs_tab/jobs_tab.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class EmployerHomeScreen extends StatefulWidget {
  const EmployerHomeScreen({super.key});
  static const String routeName = 'EmployerHomeScreen';

  @override
  State<EmployerHomeScreen> createState() => _EmployerHomeScreenState();
}

class _EmployerHomeScreenState extends State<EmployerHomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = const [
    HomeTab(),
    JobsTab(),
    AddJobTab(),
    ChatsTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome, ${Employer.currentEmployer?.name}',
          style: AppStyle.titlesTextStyle.copyWith(color: AppColors.primary),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.setting),
            color: AppColors.primary,
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
          NavigationDestination(icon: Icon(Iconsax.menu_board), label: 'Jobs'),
          NavigationDestination(icon: Icon(Iconsax.add_circle), label: 'Add'),
          NavigationDestination(icon: Icon(Iconsax.message), label: 'Chats'),
          NavigationDestination(
              icon: Icon(Iconsax.profile_circle), label: 'Profile'),
        ],
      );
}
