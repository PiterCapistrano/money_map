import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';

class CustomCircularProgress extends StatelessWidget {
  final Color? color;
  const CustomCircularProgress({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.iceWhite,
      ),
    );
  }
}
