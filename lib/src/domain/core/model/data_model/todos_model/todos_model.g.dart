// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodosModel _$TodosModelFromJson(Map<String, dynamic> json) => TodosModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      description: json['description'] as String?,
      dueDate: json['due_date'] as String?,
      status: json['status'] as String?,
      priority: json['priority'] as String?,
      completed: json['completed'] as bool?,
    );

Map<String, dynamic> _$TodosModelToJson(TodosModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'due_date': instance.dueDate,
      'status': instance.status,
      'priority': instance.priority,
      'completed': instance.completed,
    };
