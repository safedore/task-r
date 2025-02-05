import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/color.dart';

class ToDoTextField extends StatefulWidget {
  final String? hintText;
  final String? errorMessage;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool Function(String value)? validator;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final void Function(String)? onChanged;
  final TextAlign? textAlign;
  final bool? readOnly;
  final double? width;
  final String? prefixText;
  final Widget? prefixIcon;
  final TextStyle? prefixStyle;
  final Color? color;
  final FocusNode? focusNode;
  final bool obscureText;
  final Function()? onTap;

  const ToDoTextField({
    super.key,
    this.hintText,
    required this.label,
    required this.controller,
    this.errorMessage,
    required this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.textCapitalization,
    this.maxLines,
    this.onChanged,
    this.textAlign,
    this.readOnly,
    this.width,
    this.prefixText,
    this.prefixIcon,
    this.prefixStyle,
    this.color,
    this.focusNode,
    this.obscureText = false,
    this.onTap,
  });

  @override
  State<ToDoTextField> createState() => _ToDoTextFieldState();
}

class _ToDoTextFieldState extends State<ToDoTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label.isNotEmpty
            ? Padding(
                padding: EdgeInsets.only(bottom: 9.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.label,
                      style: AppTypography.latoRegular.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(
          width: widget.width ?? ScreenUtil().screenWidth,
          child: TextFormField(
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            style: AppTypography.rubikLight.copyWith(
                fontSize: 13.sp, color: widget.color ?? AppColors.blackColor),
            readOnly: widget.readOnly ?? false,
            textAlign: widget.textAlign ?? TextAlign.start,
            maxLines: widget.maxLines ?? 1,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.words,
            keyboardType: widget.keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            showCursor: true,
            obscureText: widget.obscureText ? true : false,
            cursorColor: AppColors.blackColor,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              prefixText: widget.prefixText,
              prefixStyle:
                  widget.prefixStyle ?? const TextStyle(color: Colors.black),
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor: AppColors.whiteColor,
              hintText: widget.hintText,
              hintStyle: AppTypography.latoLight.copyWith(
                fontSize: 12.sp,
                color: AppColors.blackColor,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide:
                      const BorderSide(color: AppColors.lightGreyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide:
                      const BorderSide(color: AppColors.lightGreyColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide:
                      const BorderSide(color: AppColors.lightGreyColor)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
            validator: (value) {
              if (widget.validator != null && !widget.validator!(value!)) {
                return widget.errorMessage;
              }
              return null;
            },
            controller: widget.controller,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
