import 'package:flutter/material.dart';

import 'app/presentation/main_page.dart';
import 'pokemon/presentation/pokemon_detail_page.dart';
import 'pokemon/presentation/pokemon_page.dart';
import 'splash/presentation/splash_page.dart';

// Flutter Navigation v1
class AppRouter {
  static const String initialRoute = SplashPage.routeName;

  static RouteFactory value = (RouteSettings settings) {
    var arguments = settings.arguments;
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
      case PokemonDetailPage.routeName:

        return MaterialPageRoute(
          builder: (_) => PokemonDetailPage(
            arguments: arguments as Map<String,dynamic>,
          ),
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
