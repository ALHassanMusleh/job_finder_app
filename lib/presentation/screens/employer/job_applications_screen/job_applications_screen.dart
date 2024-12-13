import 'package:flutter/material.dart';
import 'package:job_finder_app/presentation/screens/employer/employer_home_screen/tabs/home_tab/home_tab.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class JobApplicationsScreen extends StatelessWidget {
  const JobApplicationsScreen({super.key});
  static const String routeName = 'JobApplicationsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ui / Ux desgnier',
          style: AppStyle.titlesTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(onTap: () {}, child: const CustomJobCard()),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'All Applications',
              style: AppStyle.titlesTextStyle,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) =>
                    const CustomJobAppliedAndDetails(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
