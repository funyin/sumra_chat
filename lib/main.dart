import 'package:flutter/material.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_strings.dart';
import 'package:sumra_chat/core/themes/app_theme.dart';
import 'package:sumra_chat/presentation/routes/app_router.dart';

void main() {
  runApp(Sumra());
}

class Sumra extends StatelessWidget {
  Sumra({Key? key}) : super(key: key);
  var appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      color: AppColors.primary,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      onGenerateRoute: appRouter.onGenerateRoute,
      initialRoute: AppRouter.initialRoute(),
    );
  }
}
