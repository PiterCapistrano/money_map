import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';
enum SnackBarType { success, warning, error, general }
void showCustomSnackBar({
  required BuildContext context,
  required String text,
  Color? backgroundColor,
  SnackBarType type = SnackBarType.general,
}) {
  Color setColor() {
    switch (type) {
      case SnackBarType.error:
        return AppColors.red;
      case SnackBarType.success:
        return AppColors.green;
      case SnackBarType.warning:
        return AppColors.notification;
      case SnackBarType.general:
        return AppColors.grey;
    }
  }
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: AppTextStyles.smallText.apply(
          color: AppColors.iceWhite,
        ),
      ),
      backgroundColor: setColor(),
      closeIconColor: AppColors.iceWhite,
      behavior: SnackBarBehavior.floating,
    ),
  );
}