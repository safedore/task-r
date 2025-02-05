import 'dart:async';
import 'dart:io';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/domain/core/failures/api_auth_failure.dart';
import 'package:task_mgmt/src/domain/core/failures/api_failure.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/users_model/users_model.dart';
import 'package:task_mgmt/src/domain/users/i_users_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'users_event.dart';

part 'users_state.dart';

@injectable
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._usersRepository) : super(const UsersState()) {
    on<UsersProfileEvent>(_getUsersProfile);
    on<UsersListEvent>(_getUsersList);
  }

  FutureOr<void> _getUsersProfile(
      UsersEvent event, Emitter<UsersState> emit) async {
    try {
      emit(
        state.copyWith(usersProfileStatus: StatusLoading()),
      );
      final res = await _usersRepository.getUsersProfile();

      if (res.id != null) {
        emit(state.copyWith(
            usersProfileStatus: StatusSuccess(), usersProfile: res));
      } else {
        emit(
            state.copyWith(usersProfileStatus: const StatusFailure('No Data')));
      }
    } on ApiFailure {
      emit(
          state.copyWith(usersProfileStatus: const StatusFailure('Api Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          usersProfileStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          usersProfileStatus: const StatusFailure('Connection Error')));
    }
  }

  FutureOr<void> _getUsersList(
      UsersListEvent event, Emitter<UsersState> emit) async {
    try {
      emit(
        state.copyWith(usersListStatus: StatusLoading()),
      );
      final res = await _usersRepository.getUsersList();

      if (res.isNotEmpty) {
        emit(state.copyWith(usersListStatus: StatusSuccess(), usersList: res));
      } else {
        emit(state.copyWith(usersListStatus: const StatusFailure('No Data')));
      }
    } on ApiFailure {
      emit(state.copyWith(usersListStatus: const StatusFailure('Api Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          usersListStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          usersListStatus: const StatusFailure('Connection Error')));
    }
  }

  final IUsersRepository _usersRepository;
}
