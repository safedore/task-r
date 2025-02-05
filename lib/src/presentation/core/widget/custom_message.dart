import 'package:task_mgmt/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MessageStyle {
  error,
  success,
  warning,
}

class CustomMessage {
  const CustomMessage({
    required this.context,
    this.message,
    this.style = MessageStyle.success,
  });

  final BuildContext context;
  final String? message;
  final MessageStyle style;

  void show() {
    final kSize = MediaQuery.of(context).size;
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _colorBuilder(style),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            _iconBuilder(style),
            SizedBox(width: kSize.width * 0.027),
            Expanded(
              child: Text(
                message ?? '',
                maxLines: 2,
                style: AppTypography.rubikRegular
                    .copyWith(fontSize: 14.sp, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        showCloseIcon: true,
      ),
    );
  }

  void remove() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  Icon _iconBuilder(MessageStyle style) {
    switch (style) {
      case MessageStyle.error:
        return const Icon(Icons.error, color: Colors.white);
      case MessageStyle.success:
        return const Icon(Icons.verified, color: Colors.white);
      case MessageStyle.warning:
        return const Icon(Icons.warning, color: Colors.white);
    }
  }

  Color _colorBuilder(MessageStyle style) {
    switch (style) {
      case MessageStyle.error:
        return Colors.red;
      case MessageStyle.success:
        return Colors.green;
      case MessageStyle.warning:
        return Colors.black;
    }
  }
}
