import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumra_chat/bloc/bloc.dart';
import 'package:sumra_chat/bloc/state.dart';
import 'package:sumra_chat/core/constants/app_colors.dart';
import 'package:sumra_chat/core/constants/app_strings.dart';
import 'package:sumra_chat/core/data/server/mock_server.dart';
import 'package:sumra_chat/core/themes/app_theme.dart';
import 'package:sumra_chat/presentation/routes/app_routers.dart';

void main() {
  runApp(Sumra());
}

class Sumra extends StatefulWidget {
  Sumra({Key? key}) : super(key: key);

  @override
  State<Sumra> createState() => _SumraState();
}

class _SumraState extends State<Sumra> {
  var appRouter = AppRoutes();
  late var cubit = createCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => createCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        color: AppColors.primary,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        onGenerateRoute: appRouter.onGenerateRoute,
        initialRoute: AppRoutes.initialRoute(),
      ),
    );
  }

  ChatsCubit createCubit() {
    var respondents = MockServer.randomUsers;
    return ChatsCubit(ChatsState(
        recentChats: MockServer.randomChats(respondents),
        respondents: respondents,
        signedInUser: MockServer.signedInUser));
  }
}
