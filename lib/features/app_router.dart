import 'package:flutter/material.dart';

import 'app/presentation/main_page.dart';
import 'pokemon/presentation/pokemon_page.dart';
import 'splash/presentation/splash_page.dart';

// Flutter Navigation v1
class AppRouter {
  static const String initialRoute = SplashPage.routeName;

  static RouteFactory value = (RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
        );
      case MainPage.routeName:
        return MaterialPageRoute(
          builder: (_) => MainPage(),
        );
      case PokemonPage.routeName:
        return MaterialPageRoute(
          builder: (_) => PokemonPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  };
}