import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_theme_event.dart';

part 'change_theme_state.dart';

class ChangeThemeBloc extends Bloc<ChangeThemeEvent, ChangeThemeState> {
  ChangeThemeBloc(this._preferences) : super(ChangeThemeState.initial()) {
    on<CheckTheme>((event, emit) async {
      final themeMode = _preferences.getString('themeMode');
      if (themeMode != null) {
        emit(state.copyWith(themeMode: _getThemeMode(themeMode)));
      }
    });
    on<ChangeTheme>((event, emit) async {
      await _preferences.setString('themeMode', _getString(event.themeMode));
      emit(state.copyWith(themeMode: event.themeMode));
    });
  }

  final SharedPreferences _preferences;

  // get theme mode from string value
  ThemeMode _getThemeMode(String themeMode) {
    switch (themeMode) {
      case 'ThemeMode.system':
        return ThemeMode.system;
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // get string value from theme mode
  String _getString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'ThemeMode.system';
      case ThemeMode.light:
        return 'ThemeMode.light';
      case ThemeMode.dark:
        return 'ThemeMode.dark';
      default:
        return 'ThemeMode.system';
    }
  }
}
