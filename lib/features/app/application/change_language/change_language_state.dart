part of 'change_language_bloc.dart';

class ChangeLanguageState extends Equatable {
  const ChangeLanguageState({required this.locale});

  final Locale locale;

  // initial state
  factory ChangeLanguageState.initial() =>
      const ChangeLanguageState(locale: Locale('en'));

  // CopyWith method
  ChangeLanguageState copyWith({
    Locale? locale,
  }) {
    return ChangeLanguageState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale];
}
