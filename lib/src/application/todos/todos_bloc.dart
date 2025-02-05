import 'dart:async';
import 'dart:io';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/domain/core/failures/api_auth_failure.dart';
import 'package:task_mgmt/src/domain/core/failures/api_failure.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/common_response_model/common_response_model.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/confirm_model/confirm_order_model.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/todos_model/todos_model.dart';
import 'package:task_mgmt/src/domain/todos/i_todos_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'todos_event.dart';

part 'todos_state.dart';

@injectable
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc(this._todosRepository) : super(const TodosState()) {
    on<TodosListEvent>(_getTodosList);
    on<TodosCreateEvent>(_createTodosList);
    on<TodosUpdateEvent>(_updateTodosList);
    on<TodosDeleteEvent>(_deleteTodosList);
    on<TodosUpdateCompleteEvent>(_updateTodosListComplete);
  }

  FutureOr<void> _getTodosList(
      TodosListEvent event, Emitter<TodosState> emit) async {
    try {
      if (event.isRefresh || state.todosList.isEmpty) {
        emit(state.copyWith(todosListStatus: StatusLoading()));
      }
      final res = await _todosRepository.getTodosList(
          page: event.offset, limit: event.limit);
      if (res[1].isNotEmpty) {
        if (event.isRefresh) {
          emit(state.copyWith(
            todosListStatus: StatusSuccess(),
            todosList: res[1] as List<TodosModel>,
            totalCount: res[0],
          ));
        } else {
          final List<TodosModel> updatedList = [
            ...state.todosList,
            ...(res[1] as List<TodosModel>)
          ];
          emit(state.copyWith(
            todosListStatus: StatusSuccess(),
            todosList: updatedList,
            totalCount: res[0],
          ));
        }
      } else if (event.offset + event.limit >= res[0]) {
        emit(state.copyWith(
          todosListStatus: StatusSuccess(),
        ));
      } else {
        emit(state.copyWith(
          todosListStatus: const StatusFailure('No Data'),
        ));
      }
    } on ApiFailure {
      emit(state.copyWith(todosListStatus: const StatusFailure('Api Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          todosListStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          todosListStatus: const StatusFailure('Connection Error')));
    } catch (e) {
      emit(state.copyWith(
          todosListStatus: const StatusFailure('Error fetching data')));
    }
  }

  FutureOr<void> _createTodosList(
      TodosCreateEvent event, Emitter<TodosState> emit) async {
    try {
      emit(
        state.copyWith(todosCreateStatus: StatusLoading()),
      );
      final res =
          await _todosRepository.createTodosList(todos: event.todosModel);

      if (res.id != null) {
        emit(state.copyWith(
            todosCreateStatus: StatusSuccess(), todosCreateResponse: res));
      } else {
        emit(state.copyWith(todosCreateStatus: const StatusFailure('No Data')));
      }
    } on ApiFailure {
      emit(state.copyWith(todosCreateStatus: const StatusFailure('Api Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          todosCreateStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          todosCreateStatus: const StatusFailure('Connection Error')));
    } catch (e) {
      emit(state.copyWith(todosCreateStatus: const StatusFailure('Error')));
    }
  }

  FutureOr<void> _updateTodosList(
      TodosUpdateEvent event, Emitter<TodosState> emit) async {
    try {
      emit(
        state.copyWith(todosUpdateStatus: StatusLoading()),
      );
      final res =
          await _todosRepository.updateTodosList(todos: event.todosModel);

      if (res.success != null && res.success! == 'true') {
        emit(state.copyWith(todosUpdateStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(todosUpdateStatus: const StatusFailure('No Data')));
      }
    } on ApiFailure {
      emit(state.copyWith(todosUpdateStatus: const StatusFailure('Api Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          todosUpdateStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          todosUpdateStatus: const StatusFailure('Connection Error')));
    }
  }

  FutureOr<void> _deleteTodosList(
      TodosDeleteEvent event, Emitter<TodosState> emit) async {
    try {
      emit(
        state.copyWith(todosDeleteStatus: StatusLoading()),
      );
      final res = await _todosRepository.deleteTodosList(id: event.id);

      if (res.success != null && res.success! == 'true') {
        emit(state.copyWith(todosDeleteStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            todosDeleteStatus: const StatusFailure('Failed to delete')));
      }
    } on ApiFailure {
      emit(state.copyWith(todosDeleteStatus: const StatusFailure('Api Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          todosDeleteStatus: const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          todosDeleteStatus: const StatusFailure('Connection Error')));
    }
  }

  FutureOr<void> _updateTodosListComplete(
      TodosUpdateCompleteEvent event, Emitter<TodosState> emit) async {
    try {
      emit(
        state.copyWith(todosUpdateCompleteStatus: StatusLoading()),
      );
      final res = await _todosRepository.updateTodosListComplete(
          id: event.id, completed: event.completed);

      if (res.success != null && res.success! == 'true') {
        emit(state.copyWith(todosUpdateCompleteStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            todosUpdateCompleteStatus: const StatusFailure('No Data')));
      }
    } on ApiFailure {
      emit(state.copyWith(
          todosUpdateCompleteStatus: const StatusFailure('Api Error')));
    } on ApiAuthFailure {
      emit(state.copyWith(
          todosUpdateCompleteStatus:
              const StatusFailure('Authentication Error')));
    } on SocketException {
      emit(state.copyWith(
          todosUpdateCompleteStatus: const StatusFailure('Connection Error')));
    }
  }

  final ITodosRepository _todosRepository;
}
