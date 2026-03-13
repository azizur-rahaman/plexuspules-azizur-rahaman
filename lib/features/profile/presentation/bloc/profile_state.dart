import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_settings.dart';

enum ProfileStatus { initial, loading, success, error, logoutSuccess }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final NotificationSettings? settings;
  final String? message;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.settings,
    this.message,
  });

  @override
  List<Object?> get props => [status, settings, message];

  ProfileState copyWith({
    ProfileStatus? status,
    NotificationSettings? settings,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      message: message ?? this.message,
    );
  }
}
