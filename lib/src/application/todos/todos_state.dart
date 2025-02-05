part of 'todos_bloc.dart';

class TodosState extends Equatable {
  const TodosState({
    this.todosListStatus = const StatusInitial(),
    this.todosList = const <TodosModel>[],
    this.totalCount = 0,
    this.todosCreateStatus = const StatusInitial(),
    this.todosCreateResponse = const CommonResponseModel(),
    this.todosUpdateStatus = const StatusInitial(),
    this.todosUpdateResponse = const ConfirmModel(),
    this.todosDeleteStatus = const StatusInitial(),
    this.todosDeleteResponse = const ConfirmModel(),
    this.todosUpdateCompleteStatus = const StatusInitial(),
  });

  final Status todosListStatus;
  final List<TodosModel> todosList;
  final int totalCount;

  final Status todosCreateStatus;
  final CommonResponseModel todosCreateResponse;

  final Status todosUpdateStatus;
  final ConfirmModel todosUpdateResponse;
  final Status todosDeleteStatus;
  final ConfirmModel todosDeleteResponse;

  final Status todosUpdateCompleteStatus;

  @override
  List<Object> get props => [
        todosListStatus,
        todosList,
        totalCount,
        todosCreateStatus,
        todosCreateResponse,
        todosUpdateStatus,
        todosUpdateResponse,
        todosDeleteStatus,
        todosDeleteResponse,
        todosUpdateCompleteStatus,
      ];

  TodosState copyWith({
    Status? todosListStatus,
    List<TodosModel>? todosList,
    int? totalCount,
    Status? todosCreateStatus,
    CommonResponseModel? todosCreateResponse,
    Status? todosUpdateStatus,
    ConfirmModel? todosUpdateResponse,
    Status? todosDeleteStatus,
    ConfirmModel? todosDeleteResponse,
    Status? todosUpdateCompleteStatus,
  }) {
    return TodosState(
      todosListStatus: todosListStatus ?? this.todosListStatus,
      todosList: todosList ?? this.todosList,
      totalCount: totalCount ?? this.totalCount,
      todosCreateStatus: todosCreateStatus ?? this.todosCreateStatus,
      todosCreateResponse: todosCreateResponse ?? this.todosCreateResponse,
      todosUpdateStatus: todosUpdateStatus ?? this.todosUpdateStatus,
      todosUpdateResponse: todosUpdateResponse ?? this.todosUpdateResponse,
      todosDeleteStatus: todosDeleteStatus ?? this.todosDeleteStatus,
      todosDeleteResponse: todosDeleteResponse ?? this.todosDeleteResponse,
      todosUpdateCompleteStatus:
          todosUpdateCompleteStatus ?? this.todosUpdateCompleteStatus,
    );
  }
}
