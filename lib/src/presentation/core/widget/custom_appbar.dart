import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.imagePath,
    this.style,
    this.leading,
  });

  final String title;
  final String? imagePath;
  final TextStyle? style;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 140.h,
      backgroundColor: AppColors.whiteColor,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 18.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            leading ??
                InkWell(
                  highlightColor: AppColors.transparent,
                  splashColor: AppColors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppImages.backButtonIcon,
                    height: 19.h,
                    width: 22.w,
                  ),
                ),
            SizedBox(height: 26.h),
            Row(
              children: [
                Text(
                  title,
                  style: style ??
                      AppTypography.rubikRegular.copyWith(
                          fontSize: 25.sp, color: AppColors.blackColor3),
                ),
                const Spacer(),
                if (imagePath != null) ...[
                  SvgPicture.asset(imagePath!, height: 36.24.h, width: 46.w),
                  SizedBox(width: 16.w),
                ]
              ],
            ),
          ],
        ),
      ),
      leadingWidth: ScreenUtil().screenWidth,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}
