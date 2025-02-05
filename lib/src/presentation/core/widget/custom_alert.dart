import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_text_button.dart';
import 'package:task_mgmt/src/presentation/core/widget/primary_button.dart';

class CustomAlertBox extends StatelessWidget {
  const CustomAlertBox(
      {super.key, required this.title, required this.onPressed});

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 72),
          SvgPicture.asset(
            AppImages.questionCircle,
            height: 87.h,
            width: 87.w,
          ),
          SizedBox(height: 37.h),
          Text(
            title,
            style: AppTypography.rubikRegular.copyWith(fontSize: 20.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 37.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.h),
            child: Column(
              children: [
                PrimaryButton(
                  onPressed: onPressed,
                  title: 'Yes',
                ),
                CustomTextButton(
                  text: 'No',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 54),
        ],
      ),
    );
  }
}
