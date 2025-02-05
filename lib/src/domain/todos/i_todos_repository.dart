import 'package:task_mgmt/src/domain/core/model/data_model/common_response_model/common_response_model.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/confirm_model/confirm_order_model.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/todos_model/todos_model.dart';

abstract class ITodosRepository {
  Future<List<dynamic>> getTodosList({required int page, required int limit});

  Future<CommonResponseModel> createTodosList({required TodosModel todos});

  Future<ConfirmModel> updateTodosList({required TodosModel todos});

  Future<ConfirmModel> deleteTodosList({required int id});

  Future<ConfirmModel> updateTodosListComplete(
      {required int id, required bool completed});
}
