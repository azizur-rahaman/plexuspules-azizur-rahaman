import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_request_model.g.dart';

@JsonSerializable()
class AuthRequestModel extends Equatable {
  final String email;
  final String password;

  const AuthRequestModel({required this.email, required this.password});

  factory AuthRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestModelToJson(this);

  @override
  List<Object> get props => [email, password];
}
