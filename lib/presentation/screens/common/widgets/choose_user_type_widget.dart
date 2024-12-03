
import 'package:flutter/material.dart';
import 'package:job_finder_app/utils/app_assets.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class ChooseUserTypeWidget extends StatefulWidget {
  final Function(bool) onUserTypeChanged; // Callback function

  const ChooseUserTypeWidget({
    super.key,
    required this.onUserTypeChanged,
  });

  @override
  State<ChooseUserTypeWidget> createState() => _ChooseUserTypeWidgetState();
}

class _ChooseUserTypeWidgetState extends State<ChooseUserTypeWidget> {
  bool isJobSeeker = true;

  void updateSelection(bool userType) {
    setState(() {
      isJobSeeker = userType;
    });
    widget.onUserTypeChanged(userType); // Notify parent widget
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => updateSelection(true),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FA),
              border: Border.all(
                color: isJobSeeker ? AppColors.primary : AppColors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset(AppAssets.jobSeekerIcon, height: 28, width: 28),
                const SizedBox(width: 10),
                Text(
                  'Job Seeker',
                  style: AppStyle.subTitlesTextStyle.copyWith(
                    color: AppColors.bgDark,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => updateSelection(false),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FA),
              border: Border.all(
                color: !isJobSeeker ? AppColors.primary : AppColors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset(AppAssets.employerIcon, height: 28, width: 28),
                const SizedBox(width: 10),
                Text(
                  'Employer',
                  style: AppStyle.subTitlesTextStyle.copyWith(
                    color: AppColors.bgDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
