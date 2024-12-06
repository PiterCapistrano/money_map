import 'package:flutter/material.dart';
import 'package:money_map/common/constants/app_colors.dart';

final defaultTheme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.darkGreen),
    ),
  ),
);
