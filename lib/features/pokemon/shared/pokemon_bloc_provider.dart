import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/features/injection_container.dart';

import '../application/favorite_pokemon/favorite_pokemon_bloc.dart';
import '../application/filter_pokemon/filter_pokemon_bloc.dart';
import '../application/get_pokemon_list/get_pokemon_list_bloc.dart';

List<BlocProvider> pokemonBlocProviders = [
  BlocProvider<GetPokemonListBloc>(
    create: (context) => getIt<GetPokemonListBloc>(),
  ),
  BlocProvider<FavoritePokemonBloc>(
    create: (context) => getIt<FavoritePokemonBloc>(),
  ),
  BlocProvider<FilterPokemonBloc>(
    create: (context) => getIt<FilterPokemonBloc>(),
  ),
];
