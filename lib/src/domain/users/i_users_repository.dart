import 'package:task_mgmt/src/domain/core/model/data_model/users_model/users_model.dart';

abstract class IUsersRepository {
  Future<List<UsersModel>> getUsersList();

  Future<UsersModel> getUsersProfile();
}
