import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/application/auth/auth_bloc.dart';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/domain/core/pref_key/preference_key.dart';
import 'package:task_mgmt/src/infrastructure/core/preference_helper.dart';
import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:task_mgmt/src/presentation/core/constants/string.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_message.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_text_field.dart';
import 'package:task_mgmt/src/presentation/core/widget/loading.dart';
import 'package:task_mgmt/src/presentation/core/widget/primary_button.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_checkbox.dart';
import 'package:task_mgmt/src/presentation/view/auth/widget/custom_register_button.dart';
import 'package:task_mgmt/src/presentation/view/auth/widget/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController(text: 'eve.holt@reqres.in');
  final passwordController = TextEditingController(text: '12345678Aa');

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.loginStatus != current.loginStatus,
      listener: (context, state) {
        if (state.loginStatus is StatusLoading) {
          CustomLoading(context: context).show();
        } else if (state.loginStatus is StatusSuccess) {
          CustomLoading.dissmis(context);
          CustomMessage(
            context: context,
            style: MessageStyle.success,
            message: 'Welcome!',
          ).show();
          Navigator.pushNamedAndRemoveUntil(
              context, RouterConstants.homeRoute, (route) => false);
        } else if (state.loginStatus is StatusFailure) {
          CustomLoading.dissmis(context);
          CustomMessage(
            context: context,
            style: MessageStyle.warning,
            message: 'Please check your email and password',
          ).show();
        } else if (state.loginStatus is StatusInitial) {
        } else {
          CustomLoading.dissmis(context);
          CustomMessage(
            context: context,
            style: MessageStyle.warning,
            message: 'Please check your network',
          ).show();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.w, top: 100.h, right: 16.w, bottom: 16.h),
            child: Column(
              children: [
                Center(
                  child: SvgPicture.asset(
                    AppImages.appLogo,
                    height: 76.h,
                  ),
                ),
                SizedBox(height: 65.h),
                Text(
                  AppStrings.login,
                  style: AppTypography.rubikRegular.copyWith(fontSize: 20.sp),
                ),
                SizedBox(height: 19.h),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  passwordField: false,
                  hintText: 'info@task_mgmt.com',
                ),
                SizedBox(height: 17.h),
                CustomTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  passwordField: true,
                  prefixIcon: AppImages.lockIcon,
                  hintText: '***************',
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCheckbox(
                      label: AppStrings.rememberMe,
                      initialValue: false,
                      onChanged: (value) async {
                        PreferenceHelper()
                            .setBool(key: AppPrefKeys.checked, value: value);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 39.h),
                PrimaryButton(
                  title: AppStrings.login,
                  fontStyle: AppTypography.rubikMedium
                      .copyWith(fontSize: 18.sp, color: AppColors.whiteColor),
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      context.read<AuthBloc>().add(LoginEvent(
                            username: emailController.text,
                            password: passwordController.text,
                          ));
                    } else {
                      CustomMessage(
                        context: context,
                        message: 'please enter valid email and password',
                        style: MessageStyle.error,
                      ).show();
                    }
                  },
                ),
                const OrDivider(),
                SizedBox(height: 60.h),
                CustomRegisterButton(
                  onTap: () {
                    Navigator.pushNamed(context, RouterConstants.registerRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
