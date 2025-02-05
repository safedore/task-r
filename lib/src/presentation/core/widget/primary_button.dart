import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color.dart';
import '../theme/typography.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color? backgroundColor;
  final double? width;
  final double? fontSize;
  final double? height;
  final List<Color>? colors;
  final TextStyle? fontStyle;
  final BoxBorder? border;
  final Color? fontColor;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.width,
    this.fontSize,
    this.height,
    this.colors,
    this.fontStyle,
    this.border,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = colors ??
        [
          const Color(0xFF0791C8),
          const Color(0xFF22BBF7),
          const Color(0xFF22BBF7),
          const Color(0xFF0791C8),
        ];
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.circular(5.r),
              gradient: LinearGradient(colors: colors ?? gradientColors)),
          width: width ?? ScreenUtil().screenWidth,
          height: height ?? 51.h,
          child: Text(
            title,
            style: fontStyle ??
                AppTypography.latoMedium.copyWith(
                  fontSize: 18.sp,
                  color: fontColor ?? AppColors.whiteColor,
                ),
          ),
        ),
      ),
    );
  }
}
