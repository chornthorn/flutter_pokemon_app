import 'package:flutter_bloc/flutter_bloc.dart';

import 'pokemon/shared/pokemon_bloc_provider.dart';

// Global Blocs providers
class AppProviders {
  static List<BlocProvider> getProviders() {
    return [
      // spread operator (...) is used to add all
      // the elements of a list to another list
      // another word we can say is use to extends behavior of collection
      ...pokemonBlocProviders,
    ];
  }
}
