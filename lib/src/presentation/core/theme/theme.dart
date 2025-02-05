import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light(
      secondary: AppColors.secondaryColor,
    ),
  );
  static final darkTheme = ThemeData(
    checkboxTheme:
        const CheckboxThemeData(side: BorderSide(color: Colors.black)),
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.dark(
      secondary: AppColors.secondaryColor,
    ),
  );
}
