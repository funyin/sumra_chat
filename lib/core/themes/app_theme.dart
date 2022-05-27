import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_strings.dart';

class AppTheme {
  AppTheme._();

  static final light = ThemeData();
  static final dark = ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppStrings.SFProDisplay,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.primaryLight,
        titleTextStyle: TextStyle(),
      ),
      // colorScheme: ColorScheme.dark(),
      primaryColor: AppColors.purple,
      accentColor: AppColors.purple,
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.primary,
          modalBackgroundColor: AppColors.primary),
      scaffoldBackgroundColor: AppColors.primary);
}
