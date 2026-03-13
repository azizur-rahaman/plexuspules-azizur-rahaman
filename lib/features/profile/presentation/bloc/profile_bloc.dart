import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(const ProfileState()) {
    on<FetchNotificationSettings>(_onFetchNotificationSettings);
    on<UpdateNotificationSettings>(_onUpdateNotificationSettings);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onFetchNotificationSettings(
    FetchNotificationSettings event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.getNotificationSettings();
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, message: failure.message)),
      (settings) => emit(state.copyWith(status: ProfileStatus.success, settings: settings)),
    );
  }

  Future<void> _onUpdateNotificationSettings(
    UpdateNotificationSettings event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.updateNotificationSettings(event.settings);
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, message: failure.message)),
      (_) => emit(state.copyWith(status: ProfileStatus.success, settings: event.settings)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.logout();
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, message: failure.message)),
      (_) => emit(state.copyWith(status: ProfileStatus.logoutSuccess)),
    );
  }
}
