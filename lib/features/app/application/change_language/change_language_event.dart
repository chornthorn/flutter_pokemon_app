part of 'change_language_bloc.dart';

abstract class ChangeLanguageEvent extends Equatable {
  const ChangeLanguageEvent();
}

class ChangeLanguage extends ChangeLanguageEvent {
  final Locale locale;

  const ChangeLanguage(this.locale);

  @override
  List<Object> get props => [locale];
}

class CheckLanguage extends ChangeLanguageEvent {
  const CheckLanguage();

  @override
  List<Object> get props => [];
}
