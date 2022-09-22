import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_language_event.dart';

part 'change_language_state.dart';

class ChangeLanguageBloc
    extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc(this._preferences) : super(ChangeLanguageState.initial()) {
    on<CheckLanguage>((event, emit) async {
      final languageCode = _preferences.getString('languageCode');
      if (languageCode != null) {
        emit(state.copyWith(locale: Locale(languageCode)));
      }
    });

    on<ChangeLanguage>((event, emit) async {
      await _preferences.setString('languageCode', event.locale.languageCode);
      emit(state.copyWith(locale: event.locale));
    });
  }

  final SharedPreferences _preferences;
}
