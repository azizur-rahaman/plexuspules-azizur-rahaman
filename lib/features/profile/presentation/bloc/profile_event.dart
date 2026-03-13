import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_settings.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotificationSettings extends ProfileEvent {}

class UpdateNotificationSettings extends ProfileEvent {
  final NotificationSettings settings;

  const UpdateNotificationSettings(this.settings);

  @override
  List<Object?> get props => [settings];
}

class LogoutRequested extends ProfileEvent {}
