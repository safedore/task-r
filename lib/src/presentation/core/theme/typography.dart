import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static const rubikRegular = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.w400,
    fontFamily: 'Rubik',
  );

  static const rubikMedium = TextStyle(
    color: AppColors.blackColor2,
    fontWeight: FontWeight.w500,
    fontFamily: 'Rubik',
  );

  static const rubikBold = TextStyle(
    color: AppColors.secondaryColor,
    fontWeight: FontWeight.w700,
    fontFamily: 'Rubik',
  );
  static const rubikLight = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.w300,
    fontFamily: 'Rubik',
  );

  static const latoRegular = TextStyle(
    color: AppColors.darkGreyColor,
    fontWeight: FontWeight.w400,
    fontFamily: 'Lato',
  );
  static const latoMedium = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.w500,
    fontFamily: 'Lato',
  );
  static const latoLight = TextStyle(
    color: AppColors.blackColor,
    fontWeight: FontWeight.w300,
    fontFamily: 'Lato',
  );
}
