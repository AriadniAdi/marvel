import 'package:flutter/material.dart';
import 'package:marvel_app/core/theme/app_colors.dart';
import 'package:marvel_app/core/theme/app_text_style.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: AppColors.textDark,
      elevation: 0,
    ),
    textTheme: TextTheme(bodyMedium: AppTextStyles.body),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.primary,
    ),
  );
}
