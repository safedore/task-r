// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:task_mgmt/src/application/auth/auth_bloc.dart' as _i107;
import 'package:task_mgmt/src/application/todos/todos_bloc.dart' as _i143;
import 'package:task_mgmt/src/application/users/users_bloc.dart' as _i913;
import 'package:task_mgmt/src/domain/auth/i_auth_repository.dart' as _i940;
import 'package:task_mgmt/src/domain/core/internet_service/i_base_client.dart'
    as _i1015;
import 'package:task_mgmt/src/domain/core/preference/preference.dart' as _i558;
import 'package:task_mgmt/src/domain/todos/i_todos_repository.dart' as _i503;
import 'package:task_mgmt/src/domain/users/i_users_repository.dart' as _i592;
import 'package:task_mgmt/src/infrastructure/auth/auth_repository.dart'
    as _i700;
import 'package:task_mgmt/src/infrastructure/core/internet_helper.dart'
    as _i164;
import 'package:task_mgmt/src/infrastructure/core/preference_helper.dart'
    as _i312;
import 'package:task_mgmt/src/infrastructure/core/third_party_injectable_module.dart'
    as _i829;
import 'package:task_mgmt/src/infrastructure/todos/todos_repository.dart'
    as _i685;
import 'package:task_mgmt/src/infrastructure/users/users_repository.dart'
    as _i801;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyInjectableModule = _$ThirdPartyInjectableModule();
    gh.lazySingleton<_i519.Client>(() => thirdPartyInjectableModule.client);
    gh.lazySingleton<_i312.PreferenceHelper>(
        () => thirdPartyInjectableModule.preferenceHelper);
    gh.lazySingleton<_i558.PreferenceContracts>(() => _i312.PreferenceHelper());
    gh.lazySingleton<_i1015.IBaseClient>(
        () => _i164.InternetHelper(gh<_i519.Client>()));
    gh.lazySingleton<_i592.IUsersRepository>(
        () => _i801.UsersRepository(gh<_i1015.IBaseClient>()));
    gh.lazySingleton<_i940.IAuthRepository>(
        () => _i700.AuthRepository(gh<_i1015.IBaseClient>()));
    gh.lazySingleton<_i503.ITodosRepository>(
        () => _i685.TodosRepository(gh<_i1015.IBaseClient>()));
    gh.factory<_i913.UsersBloc>(
        () => _i913.UsersBloc(gh<_i592.IUsersRepository>()));
    gh.factory<_i143.TodosBloc>(
        () => _i143.TodosBloc(gh<_i503.ITodosRepository>()));
    gh.factory<_i107.AuthBloc>(
        () => _i107.AuthBloc(gh<_i940.IAuthRepository>()));
    return this;
  }
}

class _$ThirdPartyInjectableModule extends _i829.ThirdPartyInjectableModule {}
