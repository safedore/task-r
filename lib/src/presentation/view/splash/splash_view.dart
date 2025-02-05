import 'dart:async';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/domain/core/pref_key/preference_key.dart';
import 'package:task_mgmt/src/infrastructure/core/preference_helper.dart';
import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late Animation<double> easeOutAnimation;

  @override
  void initState() {
    super.initState();
    _startCountDown();
  }

  Future<void> _startCountDown() async {
    await Future.delayed(const Duration(milliseconds: 1001));
    final rememberMe =
        await PreferenceHelper().getBool(key: AppPrefKeys.checked);

    if (rememberMe && mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouterConstants.todosRoute,
        (route) => false,
      );
    } else {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouterConstants.loginRoute,
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(AppImages.appLogo),
      ),
    );
  }
}
