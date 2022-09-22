import '../../injection_container.dart';
import '../application/get_pokemon_list/get_pokemon_list_bloc.dart';
import '../infrastructure/pokemon_repository.dart';
import '../infrastructure/pokemon_service.dart';

void pokemonServiceLocator()   {
  getIt.registerLazySingleton<PokemonService>(() => PokemonService(getIt()));
  getIt.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(getIt()),
  );

  // bloc
  getIt.registerFactory(() => GetPokemonListBloc(getIt()));
}
