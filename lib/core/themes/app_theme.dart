import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_strings.dart';

class AppTheme {
  AppTheme._();

  static final light = ThemeData(
      fontFamily: AppStrings.SFProDisplay,
      textTheme: textTheme(),
      iconTheme: IconThemeData(color: AppColors.iconColorActive),
      dividerTheme: DividerThemeData(
          color: Colors.black.withOpacity(0.12), thickness: 0.5),
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.textColor,
          selectionHandleColor: AppColors.textColor),
      scaffoldBackgroundColor: AppColors.backgroundColor);

  static final dark = ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppStrings.SFProDisplay,
      primaryColor: AppColors.purple,
      accentColor: AppColors.purple,
      scaffoldBackgroundColor: AppColors.primary);

  static TextTheme textTheme() =>
      const TextTheme(bodyText1: TextStyle(color: AppColors.textColor));
}
