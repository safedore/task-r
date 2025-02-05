import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final String label;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.hintText,
    this.onChanged,
    required this.label,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final ValueNotifier<String?> _selectedValue = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _selectedValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTypography.latoRegular.copyWith(
            fontSize: 12.sp,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 9.h),
        ValueListenableBuilder<String?>(
          valueListenable: _selectedValue,
          builder: (context, selectedValue, child) {
            return DropdownButtonFormField<String>(
              dropdownColor: AppColors.whiteColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.whiteColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: AppColors.lightGreyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: AppColors.lightGreyColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: AppColors.lightGreyColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              value: selectedValue,
              hint: Text(
                widget.hintText,
                style: AppTypography.latoLight.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.blackColor,
                ),
              ),
              isExpanded: true,
              icon: SvgPicture.asset(
                AppImages.downArrowIcon,
                height: 6.sp,
                width: 6.w,
              ),
              style: AppTypography.latoRegular.copyWith(
                fontSize: 12.sp,
                color: AppColors.blackColor,
              ),
              onChanged: (String? newValue) {
                _selectedValue.value = newValue;
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              },
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: AppTypography.latoRegular.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.blackColor,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
