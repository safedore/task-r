part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  const RegisterEvent({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class LogOutEvent extends AuthEvent {
  const LogOutEvent();

  @override
  List<Object> get props => [];
}
