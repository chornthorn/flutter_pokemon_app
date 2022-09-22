import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/features/injection_container.dart';

import '../application/get_pokemon_list/get_pokemon_list_bloc.dart';

List<BlocProvider> pokemonBlocProviders = [
  BlocProvider<GetPokemonListBloc>(
    create: (context) => getIt<GetPokemonListBloc>(),
  ),
];
