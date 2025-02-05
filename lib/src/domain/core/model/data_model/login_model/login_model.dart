import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends Equatable {
  final int? id;
  final String? token;
  final String? username;
  final String? password;

  const LoginModel({this.id, this.token, this.username, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  @override
  List<Object?> get props => [id, token, username, password];
}
