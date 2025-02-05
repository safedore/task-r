import 'dart:async';
import 'dart:io';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/domain/core/failures/api_auth_failure.dart';
import 'package:task_mgmt/src/domain/core/failures/api_failure.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/login_model/login_model.dart';
import 'package:task_mgmt/src/domain/core/pref_key/preference_key.dart';
import 'package:task_mgmt/src/infrastructure/core/preference_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/auth/i_auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(
        state.copyWith(loginStatus: StatusLoading()),
      );
      final res = await _authRepository.login(
          pmLogin:
              LoginModel(username: event.username, password: event.password));

      if (res.id != null) {
        PreferenceHelper().setInt(
          key: AppPrefKeys.uId,
          value: res.id!,
        );
        PreferenceHelper().setString(
          key: AppPrefKeys.token,
          value: res.token!,
        );
        emit(state.copyWith(loginStatus: StatusSuccess(), login: res));
      } else {
        emit(state.copyWith(loginStatus: const StatusFailure('Request fail')));
      }
    } on ApiFailure {
      emit(state.copyWith(loginStatus: const StatusFailure('Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          loginStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(
          state.copyWith(loginStatus: const StatusFailure('Connection Error')));
    }
  }

  FutureOr<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      emit(
        state.copyWith(registerStatus: StatusLoading()),
      );
      final res = await _authRepository.register(
          pmLogin:
              LoginModel(username: event.username, password: event.password));

      if (res.id != null) {
        PreferenceHelper().setInt(
          key: AppPrefKeys.uId,
          value: res.id!,
        );
        emit(state.copyWith(registerStatus: StatusSuccess(), login: res));
      } else {
        emit(state.copyWith(
            registerStatus: const StatusFailure('Request fail')));
      }
    } on ApiFailure {
      emit(state.copyWith(registerStatus: const StatusFailure('Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          registerStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          registerStatus: const StatusFailure('Connection Error')));
    }
  }

  // Log out the user
  static Future<void> logout() async {
    // Clear the login token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppPrefKeys.uId);
    await prefs.remove(AppPrefKeys.checked);
  }

  final IAuthRepository _authRepository;
}
