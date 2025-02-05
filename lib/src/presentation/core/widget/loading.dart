import 'package:flutter/material.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';

class CustomLoading {
  const CustomLoading({required this.context});

  final BuildContext context;

  Future<void> show() {
    final kSize = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.whiteColor.withOpacity(0.6),
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Align(
            child: SizedBox(
              height: kSize.height * 0.071,
              width: kSize.height * 0.071,
              child: const CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void dissmis(BuildContext context) {
    Navigator.pop(context);
  }
}
