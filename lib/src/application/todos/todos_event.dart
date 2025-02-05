part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosListEvent extends TodosEvent {
  const TodosListEvent({
    required this.offset,
    required this.limit,
    required this.isRefresh,
  });

  final bool isRefresh;
  final int offset;
  final int limit;

  @override
  List<Object> get props => [offset, limit, isRefresh];
}

class TodosCreateEvent extends TodosEvent {
  const TodosCreateEvent({required this.todosModel});

  final TodosModel todosModel;

  @override
  List<Object> get props => [todosModel];
}

class TodosUpdateEvent extends TodosEvent {
  const TodosUpdateEvent({required this.todosModel});

  final TodosModel todosModel;

  @override
  List<Object> get props => [todosModel];
}

class TodosDeleteEvent extends TodosEvent {
  const TodosDeleteEvent({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class TodosUpdateCompleteEvent extends TodosEvent {
  const TodosUpdateCompleteEvent({required this.id, required this.completed});

  final int id;
  final bool completed;

  @override
  List<Object> get props => [id];
}
