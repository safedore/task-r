import 'package:task_mgmt/src/presentation/core/constants/string.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRegisterButton extends StatelessWidget {
  const CustomRegisterButton({
    super.key,
    required this.onTap,
    this.text,
    this.subText,
    this.style,
    this.subStyle,
  });

  final Function() onTap;
  final String? text;
  final String? subText;
  final TextStyle? style;
  final TextStyle? subStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: subText ?? AppStrings.newUser,
          style: style ?? AppTypography.rubikRegular.copyWith(fontSize: 12.sp),
          children: [
            TextSpan(
              text: text ?? AppStrings.register,
              style:
                  subStyle ?? AppTypography.rubikBold.copyWith(fontSize: 12.sp),
            )
          ],
        ),
      ),
    );
  }
}
