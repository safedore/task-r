import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/application/auth/auth_bloc.dart';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:task_mgmt/src/presentation/core/constants/string.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_message.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_text_field.dart';
import 'package:task_mgmt/src/presentation/core/widget/loading.dart';
import 'package:task_mgmt/src/presentation/core/widget/primary_button.dart';
import 'package:task_mgmt/src/presentation/view/auth/widget/custom_register_button.dart';
import 'package:task_mgmt/src/presentation/view/auth/widget/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  String mailError = 'please enter an email';
  String pError = 'please enter password';
  String cpError = 'please enter confirm password';

  final formKey = GlobalKey<FormState>();

  final passRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.registerStatus != current.registerStatus,
      listener: (context, state) {
        if (state.registerStatus is StatusLoading) {
          CustomLoading(context: context).show();
        } else if (state.registerStatus is StatusInitial) {
        } else if (state.registerStatus is StatusSuccess) {
          CustomLoading.dissmis(context);
          Navigator.pushNamedAndRemoveUntil(
              context, RouterConstants.loginRoute, (route) => false);
        } else {
          CustomLoading.dissmis(context);
          CustomMessage(
                  context: context,
                  message: 'Please check your internet connection',
                  style: MessageStyle.warning)
              .show();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                    AppStrings.register2,
                    style: AppTypography.rubikRegular.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 19.h),
                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    passwordField: false,
                    hintText: 'info@task_mgmt.com',
                    errorMessage: mailError,
                    validator: (value) {
                      return mailError == '';
                    },
                    onChanged: (p0) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(p0)) {
                        setState(() {
                          mailError = '';
                        });
                      } else {
                        setState(() {
                          mailError = 'please enter valid email';
                        });
                      }
                    },
                  ),
                  SizedBox(height: 17.h),
                  CustomTextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    passwordField: true,
                    prefixIcon: AppImages.lockIcon,
                    hintText: '***************',
                    errorMessage: pError,
                    onChanged: (p0) {
                      setState(() {
                        if (p0.isEmpty) {
                          pError = 'please enter password';
                        } else if (passRegex.hasMatch(p0)) {
                          pError = '';
                        } else {
                          pError =
                              'password should contain 1 uppercase, 1 lowercase, 1 number \nand 8 characters';
                        }
                        if (pError == '') {
                          if (p0 != cPasswordController.text) {
                            pError = 'password not matched';
                          } else if (p0 == cPasswordController.text) {
                            cpError = '';
                          }
                        }
                      });
                    },
                    validator: (value) {
                      return pError == '';
                    },
                  ),
                  SizedBox(height: 17.h),
                  CustomTextField(
                    controller: cPasswordController,
                    keyboardType: TextInputType.text,
                    passwordField: true,
                    prefixIcon: AppImages.lockIcon,
                    errorMessage: cpError,
                    validator: (value) {
                      return cpError == '';
                    },
                    hintText: '***************',
                    onChanged: (p0) {
                      setState(() {
                        if (p0 != passwordController.text) {
                          cpError = 'password not matched';
                        } else {
                          if (p0 == passwordController.text &&
                              passRegex.hasMatch(p0)) {
                            pError = '';
                          }
                          cpError = '';
                        }
                      });
                    },
                  ),
                  SizedBox(height: 29.h),
                  PrimaryButton(
                    title: AppStrings.register,
                    fontStyle: AppTypography.rubikMedium
                        .copyWith(fontSize: 18.sp, color: AppColors.whiteColor),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              RegisterEvent(
                                username: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  const OrDivider(),
                  SizedBox(height: 80.h),
                  CustomRegisterButton(
                    text: AppStrings.login,
                    subText: AppStrings.alreadyHaveAcnt,
                    onTap: () {
                      Navigator.pushNamed(context, RouterConstants.loginRoute);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
