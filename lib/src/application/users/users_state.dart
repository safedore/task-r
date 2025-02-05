part of 'users_bloc.dart';

class UsersState extends Equatable {
  const UsersState({
    this.usersListStatus = const StatusInitial(),
    this.usersList = const <UsersModel>[],
    this.usersProfileStatus = const StatusInitial(),
    this.usersProfile = const UsersModel(),
  });

  final Status usersListStatus;
  final List<UsersModel> usersList;

  final Status usersProfileStatus;
  final UsersModel usersProfile;

  @override
  List<Object> get props => [
        usersListStatus,
        usersList,
        usersProfileStatus,
        usersProfile,
      ];

  UsersState copyWith({
    Status? usersListStatus,
    List<UsersModel>? usersList,
    Status? usersProfileStatus,
    UsersModel? usersProfile,
  }) {
    return UsersState(
      usersListStatus: usersListStatus ?? this.usersListStatus,
      usersList: usersList ?? this.usersList,
      usersProfileStatus: usersProfileStatus ?? this.usersProfileStatus,
      usersProfile: usersProfile ?? this.usersProfile,
    );
  }
}
