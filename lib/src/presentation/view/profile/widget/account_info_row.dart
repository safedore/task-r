import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountInfoTile extends StatelessWidget {
  final String title;
  final String iconPath;

  const AccountInfoTile({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  height: 18.h,
                  width: 16.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  title,
                  style: AppTypography.latoRegular
                      .copyWith(fontSize: 12.sp, color: AppColors.blackColor),
                ),
              ],
            ),
            SizedBox(
              height: 13.h,
            ),
            Container(
              height: 1.h,
              width: ScreenUtil().screenWidth * 0.87,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.1),
                    offset: const Offset(1, 4),
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ],
    );
  }
}
