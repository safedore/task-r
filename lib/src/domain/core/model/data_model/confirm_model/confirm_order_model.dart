import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_order_model.g.dart';

@JsonSerializable()
class ConfirmModel extends Equatable {
  final String? success;

  const ConfirmModel({this.success});

  factory ConfirmModel.fromJson(Map<String, dynamic> json) {
    return _$ConfirmModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfirmModelToJson(this);

  @override
  List<Object?> get props => [success];
}
