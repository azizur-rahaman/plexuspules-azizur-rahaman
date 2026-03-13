import 'package:equatable/equatable.dart';

class NotificationSettings extends Equatable {
  final bool pushEnabled;
  final bool emailEnabled;
  final double alertThreshold;

  const NotificationSettings({
    required this.pushEnabled,
    required this.emailEnabled,
    required this.alertThreshold,
  });

  @override
  List<Object?> get props => [pushEnabled, emailEnabled, alertThreshold];

  NotificationSettings copyWith({
    bool? pushEnabled,
    bool? emailEnabled,
    double? alertThreshold,
  }) {
    return NotificationSettings(
      pushEnabled: pushEnabled ?? this.pushEnabled,
      emailEnabled: emailEnabled ?? this.emailEnabled,
      alertThreshold: alertThreshold ?? this.alertThreshold,
    );
  }
}
