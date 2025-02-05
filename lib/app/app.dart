import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/app/injector/injector.dart';
import 'package:task_mgmt/app/router/router.dart';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/application/auth/auth_bloc.dart';
import 'package:task_mgmt/src/application/todos/todos_bloc.dart';
import 'package:task_mgmt/src/application/users/users_bloc.dart';
import 'package:task_mgmt/src/presentation/core/constants/string.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<TodosBloc>()),
        BlocProvider(create: (context) => getIt<UsersBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 760),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(.99),
                ),
                child: child!,
              );
            },
            title: AppStrings.appName,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            initialRoute: RouterConstants.splashRoute,
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
