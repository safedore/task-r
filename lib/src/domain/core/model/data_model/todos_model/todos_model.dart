import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todos_model.g.dart';

@JsonSerializable()
class TodosModel extends Equatable {
  final int? id;
  final int? userId;
  final String? title;
  final String? description;
  @JsonKey(name: 'due_date')
  final String? dueDate;
  final String? status;
  final String? priority;
  final bool? completed;

  const TodosModel(
      {this.id,
      this.title,
      this.userId,
      this.description,
      this.dueDate,
      this.status,
      this.priority,
      this.completed});

  factory TodosModel.fromJson(Map<String, dynamic> json) =>
      _$TodosModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodosModelToJson(this);

  @override
  List<Object?> get props =>
      [id, title, userId, description, dueDate, status, priority, completed];
}
