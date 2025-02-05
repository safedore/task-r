import 'package:task_mgmt/src/domain/core/model/data_model/login_model/login_model.dart';

abstract class IAuthRepository {
  Future<LoginModel> login({required LoginModel pmLogin});

  Future<LoginModel> register({required LoginModel pmLogin});
}
