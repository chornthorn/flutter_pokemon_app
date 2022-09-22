part of 'change_theme_bloc.dart';

class ChangeThemeState extends Equatable {
  const ChangeThemeState({this.themeMode = ThemeMode.system});

  final ThemeMode themeMode;

  // initial state
  factory ChangeThemeState.initial() => const ChangeThemeState();

  // CopyWith method
  ChangeThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ChangeThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [themeMode];
}
