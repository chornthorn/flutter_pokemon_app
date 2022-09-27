import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokemon_app/common/l10n/l10n.dart';
import 'package:pokemon_app/features/app_router.dart';

import '../../app_provider.dart';
import '../application/change_language/change_language_bloc.dart';
import '../application/change_theme/change_theme_bloc.dart';

class AppIndex extends StatelessWidget {
  const AppIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProviders.getProviders(),
      child: _AppIndex(),
    );
  }
}

// Try to use stateless widget as possible as you can at the top level
class _AppIndex extends StatelessWidget {
  const _AppIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // use bloc selector listen to state change and rebuild only when state change
    return BlocSelector<ChangeThemeBloc, ChangeThemeState, ThemeMode>(
      selector: (state) {
        return state.themeMode;
      },
      builder: (context, themeState) {
        return BlocSelector<ChangeLanguageBloc, ChangeLanguageState, Locale>(
          selector: (state) {
            return state.locale;
          },
          builder: (context, langState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'NatoSansKhmer',
                colorScheme: ColorScheme.light(
                  primary: Colors.indigo,
                  secondary: Colors.indigoAccent,
                ),
              ),
              // set dark theme
              darkTheme: ThemeData(
                fontFamily: 'NatoSansKhmer',
                brightness: Brightness.dark,
                colorScheme: ColorScheme.dark(
                  primary: Colors.green,
                  secondary: Colors.greenAccent,
                ),
              ),
              // set theme mode
              themeMode: themeState,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: langState,
              initialRoute: AppRouter.initialRoute,
              onGenerateRoute: AppRouter.value,
            );
          },
        );
      },
    );
  }
}
