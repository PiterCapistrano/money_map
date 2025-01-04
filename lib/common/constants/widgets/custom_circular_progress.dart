import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.iceWhite,
      ),
    );
  }
}
