import 'package:flutter/material.dart';
import 'package:job_finder_app/utils/app_colors.dart';

abstract class AppStyle {
  static const TextStyle appBarStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.white);
  static const TextStyle titlesTextStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Color(0xff15141F),
      fontFamily: 'fontBold');

  static const TextStyle subTitlesTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xffA2A0A8),
      fontFamily: 'fontBold');

  static const TextStyle labelStyle = TextStyle(
      fontSize: 16, color: Color(0xff717171), fontFamily: 'fontRegular');

  static const TextStyle titlesJobTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Color(0xff15141F),
      fontFamily: 'fontBold');

  static BoxDecoration containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(
      color: const Color(0xFFF9F9FA),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.1),
        offset: const Offset(
          0.0,
          0.0,
        ),
        blurRadius: 10.0,
        spreadRadius: 2.0,
      ), //BoxShadow
      const BoxShadow(
        color: Colors.white,
        offset: const Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ), //BoxShadow
    ],
  );

  static const TextStyle bottomSheetTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.black);

  static const TextStyle bodyTextStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black);
  static const TextStyle unSelectedCalendarDayStyle = TextStyle(
      color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 15);

  static TextStyle selectedCalendarDayStyle =
      unSelectedCalendarDayStyle.copyWith(color: AppColors.primary);
  static const TextStyle appBarDarkStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.black);

  static const TextStyle unselectedCalenderDayStyle = TextStyle(
      color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 15);
  static TextStyle selectedCalenderDayStyle =
      unselectedCalenderDayStyle.copyWith(color: AppColors.primary);

  static const TextStyle normalGreyTextStyle = TextStyle(
      fontSize: 16, color: AppColors.grey, fontWeight: FontWeight.w500);
}
