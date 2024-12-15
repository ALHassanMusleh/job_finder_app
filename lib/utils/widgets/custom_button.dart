import 'package:flutter/material.dart';
import 'package:job_finder_app/utils/app_colors.dart';
import 'package:job_finder_app/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isWhiteBg = false,
  });
  final String title;
  final void Function() onPressed;
  final bool isWhiteBg;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isWhiteBg ? AppColors.white : AppColors.primary,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: isWhiteBg
              ? const BorderSide(color: AppColors.primary, width: 1)
              : BorderSide.none,
        ),
      ),
      child: Text(
        title,
        style: AppStyle.subTitlesTextStyle.copyWith(
          color:isWhiteBg ? AppColors.primary: AppColors.white,
        ),
      ),
    );
  }
}
