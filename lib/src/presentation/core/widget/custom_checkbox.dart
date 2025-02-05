import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    super.key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late ValueNotifier<bool> isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = ValueNotifier(widget.initialValue);
  }

  @override
  void dispose() {
    isChecked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isChecked.value = !isChecked.value;
        widget.onChanged(isChecked.value);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: isChecked,
            builder: (context, value, child) {
              return Container(
                alignment: Alignment.center,
                width: 12.w,
                height: 10.h,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: value ? AppColors.primaryColor : AppColors.whiteColor,
                  border: Border.all(
                    color: value
                        ? AppColors.primaryColor
                        : AppColors.lightGreyColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(1.r),
                ),
                child: value
                    ? Icon(
                        Icons.check,
                        size: 8.sp,
                        color: AppColors.whiteColor,
                      )
                    : null,
              );
            },
          ),
          SizedBox(width: 8.w),
          Text(
            widget.label,
            style: AppTypography.rubikRegular.copyWith(
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
