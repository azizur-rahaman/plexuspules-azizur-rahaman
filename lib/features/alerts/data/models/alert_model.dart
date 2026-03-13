import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/alert.dart';

part 'alert_model.g.dart';

@JsonSerializable()
class AlertModel extends Alert {
  const AlertModel({
    required super.id,
    required super.title,
    required super.description,
    required super.severity,
    required super.timestamp,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) => _$AlertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlertModelToJson(this);
}
