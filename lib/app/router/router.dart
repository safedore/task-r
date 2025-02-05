import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/todos_model/todos_model.dart';
import 'package:task_mgmt/src/presentation/view/auth/login/login_view.dart';
import 'package:task_mgmt/src/presentation/view/auth/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:task_mgmt/src/presentation/view/profile/profile.dart';
import 'package:task_mgmt/src/presentation/view/splash/splash_view.dart';
import 'package:task_mgmt/src/presentation/view/todos_view/todos_create_view.dart';
import 'package:task_mgmt/src/presentation/view/todos_view/todos_list_view.dart';
import 'package:task_mgmt/src/presentation/view/todos_view/todos_update_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterConstants.splashRoute:
        return MaterialPageRoute<SplashView>(
          builder: (_) => const SplashView(),
        );
      case RouterConstants.loginRoute:
        return MaterialPageRoute<LoginView>(
          builder: (_) => const LoginView(),
        );
      case RouterConstants.registerRoute:
        return MaterialPageRoute<RegisterView>(
          builder: (_) => const RegisterView(),
        );

      case RouterConstants.homeRoute:
        return MaterialPageRoute<TodosListView>(
          builder: (_) => const TodosListView(),
        );

      case RouterConstants.profileRoute:
        return MaterialPageRoute<ProfileView>(
          builder: (_) => const ProfileView(),
        );

      case RouterConstants.todosRoute:
        return MaterialPageRoute<TodosListView>(
          builder: (_) => const TodosListView(),
        );
      case RouterConstants.createTodosRoute:
        return MaterialPageRoute<TodosCreateView>(
          builder: (_) => const TodosCreateView(),
        );
      case RouterConstants.updateTodosRoute:
        final args = settings.arguments as List;
        return MaterialPageRoute<TodosUpdateView>(
          builder: (_) =>
              TodosUpdateView(
                data: args[0] as TodosModel,
              ),
        );

      default:
        return MaterialPageRoute<Scaffold>(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
