part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersListEvent extends UsersEvent {
  const UsersListEvent();

  @override
  List<Object> get props => [];
}

class UsersProfileEvent extends UsersEvent {
  const UsersProfileEvent();

  @override
  List<Object> get props => [];
}
