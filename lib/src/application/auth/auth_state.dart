part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.loginStatus = const StatusInitial(),
    this.login = const LoginModel(),
    this.registerStatus = const StatusInitial(),
    this.logoutStatus = const StatusInitial(),
  });

  final Status loginStatus;
  final LoginModel login;
  final Status registerStatus;
  final Status logoutStatus;

  @override
  List<Object> get props => [loginStatus, login, registerStatus, logoutStatus];

  AuthState copyWith({
    Status? loginStatus,
    LoginModel? login,
    Status? registerStatus,
    Status? logoutStatus,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      login: login ?? this.login,
      registerStatus: registerStatus ?? this.registerStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
    );
  }
}
