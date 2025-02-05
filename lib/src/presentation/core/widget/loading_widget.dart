import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {super.key, required this.length, this.height, this.width});

  final int length;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGreyColor,
      highlightColor: AppColors.whiteColor,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: length,
        itemBuilder: (context, index) {
          return Container(
            height: height ?? 100.h,
            width: width ?? ScreenUtil().screenWidth,
            margin: EdgeInsets.only(left: 16.w, top: 8.h, right: 16.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
          );
        },
      ),
    );
  }
}
