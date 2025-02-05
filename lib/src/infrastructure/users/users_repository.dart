import 'dart:convert';
import 'package:task_mgmt/src/domain/core/model/data_model/users_model/users_model.dart';
import 'package:task_mgmt/src/domain/core/pref_key/preference_key.dart';
import 'package:task_mgmt/src/domain/users/i_users_repository.dart';
import 'package:task_mgmt/src/domain/core/app_url/app_urls.dart';
import 'package:task_mgmt/src/domain/core/internet_service/i_base_client.dart';
import 'package:injectable/injectable.dart';
import 'package:task_mgmt/src/infrastructure/core/preference_helper.dart';

@LazySingleton(as: IUsersRepository)
class UsersRepository extends IUsersRepository {
  UsersRepository(this.client);

  final IBaseClient client;

  @override
  Future<List<UsersModel>> getUsersList() async {
    try {
      final response = await client
          .get(url: '${AppUrls.usersListUrl}/')
          .timeout(const Duration(seconds: 15));
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      final data = decode['data'] as List;
      return data
          .map((e) => UsersModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return <UsersModel>[];
    }
  }

  @override
  Future<UsersModel> getUsersProfile() async {
    try {
      final uid = await PreferenceHelper().getInt(key: AppPrefKeys.uId);
      final response = await client
          .get(url: '${AppUrls.usersListUrl}/$uid')
          .timeout(const Duration(seconds: 15));
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return UsersModel.fromJson(decode['data']);
    } catch (e) {
      return const UsersModel();
    }
  }
}
