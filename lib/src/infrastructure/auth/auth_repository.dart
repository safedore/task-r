import 'dart:convert';
import 'package:task_mgmt/src/domain/auth/i_auth_repository.dart';
import 'package:task_mgmt/src/domain/core/app_url/app_urls.dart';
import 'package:task_mgmt/src/domain/core/internet_service/i_base_client.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/login_model/login_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository extends IAuthRepository {
  AuthRepository(this.client);

  final IBaseClient client;

  @override
  Future<LoginModel> login({required LoginModel pmLogin}) async {
    final String userName = pmLogin.username!;
    final String password = pmLogin.password!;
    try {
      final response = await client.post(
        // url: AppUrls.loginUrl,
        url: AppUrls.registerUrl,
        body: {
          "email": userName,
          "password": password,
        },
      ).timeout(const Duration(seconds: 15));
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return LoginModel.fromJson(decode);
    } catch (e) {
      return const LoginModel();
    }
  }

  @override
  Future<LoginModel> register({required LoginModel pmLogin}) async {
    final String userName = pmLogin.username!;
    final String password = pmLogin.password!;
    // try {
    final response = await client.post(
      url: AppUrls.registerUrl,
      body: {
        "email": userName,
        "password": password,
      },
    ).timeout(const Duration(seconds: 15));
    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    return LoginModel.fromJson(decode);
    // } catch (e) {
    //   print(e);
    //   return const LoginModel();
    // }
  }
}
