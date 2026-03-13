import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/notification_settings.dart';

part 'notification_settings_model.g.dart';

@JsonSerializable()
class NotificationSettingsModel extends NotificationSettings {
  const NotificationSettingsModel({
    required super.pushEnabled,
    required super.emailEnabled,
    required super.alertThreshold,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSettingsModelToJson(this);

  factory NotificationSettingsModel.fromEntity(NotificationSettings entity) {
    return NotificationSettingsModel(
      pushEnabled: entity.pushEnabled,
      emailEnabled: entity.emailEnabled,
      alertThreshold: entity.alertThreshold,
    );
  }
}
