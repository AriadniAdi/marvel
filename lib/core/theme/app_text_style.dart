import 'package:flutter/material.dart';
import 'package:marvel_app/core/theme/app_colors.dart';

class AppTextStyles {
  static TextStyle heroName = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static TextStyle title = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  static TextStyle body = TextStyle(color: AppColors.textDark, fontSize: 14);
}
