import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/hive_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final HiveService _hiveService;

  ThemeBloc(this._hiveService) : super(const ThemeState(ThemeMode.light)) {
    on<LoadTheme>(_onLoadTheme);
    on<ThemeChanged>(_onThemeChanged);
    
    // Initial load
    add(const LoadTheme());
  }

  FutureOr<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) {
    final modeString = _hiveService.getThemeMode();
    final themeMode = _themeModeFromString(modeString);
    emit(ThemeState(themeMode));
  }

  FutureOr<void> _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    await _hiveService.setThemeMode(event.themeMode.name);
    emit(ThemeState(event.themeMode));
  }

  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      case 'light':
      default:
        return ThemeMode.light;
    }
  }
}
