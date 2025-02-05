import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/color.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? errorMessage;
  final String? label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool Function(String value)? validator;
  final bool passwordField;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final void Function(String)? onChanged;
  final TextAlign? textAlign;
  final bool? readOnly;
  final double? width;
  final String? prefixText;
  final String? prefixIcon;
  final TextStyle? prefixStyle;
  final Color? color;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.hintText,
    this.label,
    required this.controller,
    this.errorMessage,
    required this.keyboardType,
    this.validator,
    required this.passwordField,
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
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> obscureText = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: obscureText,
        builder: (BuildContext context, bool value, Widget? child) {
          return SizedBox(
            width: widget.width ?? ScreenUtil().screenWidth,
            child: TextFormField(
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
              obscuringCharacter: '*',
              cursorColor: AppColors.blackColor,
              obscureText: widget.passwordField ? obscureText.value : false,
              decoration: InputDecoration(
                prefixIcon: Container(
                  width: 30.w,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16.w),
                  child: SvgPicture.asset(
                    alignment: Alignment.center,
                    widget.prefixIcon ?? AppImages.emailIcon,
                    height: 15.h,
                    width: 15.w,
                  ),
                ),
                prefixText: widget.prefixText,
                prefixStyle:
                    widget.prefixStyle ?? const TextStyle(color: Colors.black),
                suffixIcon:
                    widget.passwordField ? passwordIcon() : widget.suffixIcon,
                filled: true,
                fillColor: AppColors.textFieldColor.withOpacity(0.3),
                hintText: widget.hintText,
                hintStyle: AppTypography.rubikLight.copyWith(fontSize: 11.sp),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide.none),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide.none),
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
          );
        });
  }

  Widget passwordIcon() {
    return IconButton(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onPressed: () {
        obscureText.value = !obscureText.value;
      },
      icon: ValueListenableBuilder(
        valueListenable: obscureText,
        builder: (BuildContext context, bool value, Widget? child) {
          return SvgPicture.asset(
            alignment: Alignment.center,
            obscureText.value ? AppImages.eyeOpenIcon : AppImages.eyeOffIcon,
            height: 16.h,
            width: 16.w,
          );
        },
      ),
    );
  }
}
