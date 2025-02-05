import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';

class CustomModelDropDown extends StatefulWidget {
  final String title;
  final String hintText;
  final List<dynamic> valueList;
  final Function(dynamic) onSelected;
  final dynamic selectedItem;

  const CustomModelDropDown(
      {super.key,
      required this.title,
      required this.hintText,
      required this.valueList,
      required this.onSelected,
      this.selectedItem});

  @override
  State<CustomModelDropDown> createState() => _CustomModelDropDownState();
}

class _CustomModelDropDownState extends State<CustomModelDropDown> {
  dynamic _selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.valueList.isNotEmpty) {
      _selectedItem = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppTypography.latoRegular.copyWith(
            fontSize: 12.sp,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: 10.h),
        DropdownButtonFormField<dynamic>(
          dropdownColor: AppColors.whiteColor,
          style: AppTypography.latoLight
              .copyWith(fontSize: 12.sp, color: AppColors.blackColor),
          // validator: (val) {
          //   if (val == null) {
          //     return 'Please select a employee';
          //   }
          //   return null;
          // },
          hint: Text(
            widget.hintText,
            style: AppTypography.latoLight.copyWith(
              fontSize: 12.sp,
              color: AppColors.blackColor,
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.greyColor,
            size: 24.h,
          ),
          isExpanded: true,
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
          value: widget.selectedItem == null
              ? _selectedItem
              : widget.valueList
                  .where(
                    (element) => element.id == widget.selectedItem,
                  )
                  .first,
          onChanged: (value) {
            setState(() {
              widget.onSelected(value!);
            });
          },
          items:
              widget.valueList.map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text('${value.firstName!} ${value.lastName!}',
                  style: AppTypography.latoRegular
                      .copyWith(fontSize: 12.sp, color: AppColors.blackColor)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
