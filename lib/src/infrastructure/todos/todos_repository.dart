import 'dart:convert';
import 'package:task_mgmt/src/domain/core/model/data_model/common_response_model/common_response_model.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/confirm_model/confirm_order_model.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/todos_model/todos_model.dart';
import 'package:task_mgmt/src/domain/core/pref_key/preference_key.dart';
import 'package:task_mgmt/src/domain/todos/i_todos_repository.dart';
import 'package:task_mgmt/src/domain/core/app_url/app_urls.dart';
import 'package:task_mgmt/src/domain/core/internet_service/i_base_client.dart';
import 'package:injectable/injectable.dart';
import 'package:task_mgmt/src/infrastructure/core/db_helper.dart';
import 'package:task_mgmt/src/infrastructure/core/preference_helper.dart';

@LazySingleton(as: ITodosRepository)
class TodosRepository extends ITodosRepository {
  TodosRepository(this.client);

  final IBaseClient client;

  @override
  Future<List<dynamic>> getTodosList(
      {required int page, required int limit}) async {
    syncAll();
    try {
      // final uid = await PreferenceHelper().getInt(key: AppPrefKeys.uId);
      // final response = await client.get(url: '${AppUrls.todosListUrl}/?userId=$uid').timeout(const Duration(seconds: 15));
      // final decode = jsonDecode(response.body) as List<dynamic>;
      final decode =
          await DbHelper.instance.queryAllRows(false, page: page, limit: limit);
      List<Map<String, dynamic>> mDecode = [];
      for (var e in decode[1]) {
        mDecode.add(e.map<String, dynamic>(
          (key, value) => MapEntry<String, dynamic>(
            key,
            key == 'completed' ? value == 1 : value,
          ),
        ));
      }
      return [decode[0], (mDecode).map((e) => TodosModel.fromJson(e)).toList()];
    } catch (e) {
      return <TodosModel>[];
    }
  }

  @override
  Future<CommonResponseModel> createTodosList(
      {required TodosModel todos}) async {
    final uid = await PreferenceHelper().getInt(key: AppPrefKeys.uId);

    var dbResponse = todos.id;
    dbResponse ??= await DbHelper.instance.insert(todos.toJson());

    try {
      final response = await client.post(url: AppUrls.todosCreateUrl, body: {
        'userId': uid.toString(),
        'title': todos.title,
        'completed': 'false',
      }).timeout(const Duration(seconds: 15));
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      await DbHelper.instance.sync(dbResponse, decode['id']);
      return CommonResponseModel.fromJson(decode);
    } catch (e) {
      return CommonResponseModel(id: dbResponse);
    }
  }

  @override
  Future<ConfirmModel> updateTodosList({required TodosModel todos}) async {
    final dbResponse = await DbHelper.instance.update(todos.toJson());
    final res = await DbHelper.instance.querySingleRows(todos.id!);
    if (res.first['sync_id'] != 0) {
      try {
        final response = await client.put(
            url: '${AppUrls.todosUpdateUrl}/${res.first['sync_id']}',
            body: {
              'title': todos.title,
              'completed': '${todos.completed ?? false}',
            }).timeout(const Duration(seconds: 15));
        final decode = jsonDecode(response.body) as Map<String, dynamic>;
        if (decode['id'] != null) {
          decode['success'] = 'true';
        }
        return ConfirmModel.fromJson(decode);
      } catch (e) {
        return ConfirmModel(success: dbResponse != 0 ? 'true' : 'false');
      }
    }

    return ConfirmModel(success: dbResponse != 0 ? 'true' : 'false');
  }

  @override
  Future<ConfirmModel> deleteTodosList({required int id}) async {
    final dbResponse = await DbHelper.instance.update({'id': id, 'deleted': 1});
    try {
      final response = await client
          .delete(
            url: '${AppUrls.todosDeleteUrl}/$id',
          )
          .timeout(const Duration(seconds: 15));
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      if (decode.isEmpty) {
        decode['success'] = 'true';
      }
      await DbHelper.instance.delete(id);
      return ConfirmModel.fromJson(decode);
    } catch (e) {
      return ConfirmModel(success: dbResponse != 0 ? 'true' : 'false');
    }
  }

  @override
  Future<ConfirmModel> updateTodosListComplete(
      {required int id, required bool completed}) async {
    final data = {'id': id, 'completed': completed};
    final dbResponse = await DbHelper.instance.update(data);
    final res = await DbHelper.instance.querySingleRows(id);
    if (res.first['sync_id'] != 0) {
      try {
        final response = await client.put(
            url: '${AppUrls.todosUpdateUrl}/${res.first['sync_id']}',
            body: {
              'completed': '$completed',
            }).timeout(const Duration(seconds: 15));
        final decode = jsonDecode(response.body) as Map<String, dynamic>;
        if (decode['id'] != null) {
          decode['success'] = 'true';
        }
        return ConfirmModel.fromJson(decode);
      } catch (e) {
        return ConfirmModel(success: dbResponse != 0 ? 'true' : 'false');
      }
    }

    return ConfirmModel(success: dbResponse != 0 ? 'true' : 'false');
  }

  Future<void> syncAll() async {
    final todosList = await DbHelper.instance.queryAllRows(true);
    for (var e in todosList[1]) {
      final todos = TodosModel(
        id: e['id'],
        title: e['title'],
        userId: e['userId'],
        completed: e['completed'] == 1 ? true : false,
      );
      final response = await createTodosList(todos: todos);
      if (response.id != null) {
        await DbHelper.instance.sync(e['id'], response.id!);
      }
    }
  }
}
