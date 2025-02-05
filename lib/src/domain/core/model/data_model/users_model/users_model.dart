import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_model.g.dart';

@JsonSerializable()
class UsersModel extends Equatable {
  final int? id;
  final String? email;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? avatar;

  const UsersModel(
      {this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
