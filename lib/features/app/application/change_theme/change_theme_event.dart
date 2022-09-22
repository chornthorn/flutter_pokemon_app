part of 'change_theme_bloc.dart';

abstract class ChangeThemeEvent extends Equatable {
  const ChangeThemeEvent();
}

class ChangeTheme extends ChangeThemeEvent {
  final ThemeMode themeMode;

  const ChangeTheme(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

class CheckTheme extends ChangeThemeEvent {
  const CheckTheme();

  @override
  List<Object> get props => [];
}
