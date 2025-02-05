import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';

class CustomPlaceholder extends StatelessWidget {
  const CustomPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(AppImages.noData, height: 230.h));
  }
}
