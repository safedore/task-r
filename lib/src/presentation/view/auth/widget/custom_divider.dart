import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.h,
            color: AppColors.greyColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            'or',
            style: AppTypography.rubikRegular.copyWith(
              fontSize: 14.sp,
              color: AppColors.greyColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1.h,
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
