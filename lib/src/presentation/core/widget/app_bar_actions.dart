import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppBarActions extends StatefulWidget {
  const AppBarActions(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.tag,
      this.height});

  final Function() onPressed;
  final String icon;
  final String tag;
  final double? height;

  @override
  State<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: widget.onPressed,
        child: Hero(
          tag: widget.tag,
          child: SvgPicture.asset(
            widget.icon,
            height: widget.height ?? 19.h,
            width: 22.w,
          ),
        ),
      ),
    );
  }
}
