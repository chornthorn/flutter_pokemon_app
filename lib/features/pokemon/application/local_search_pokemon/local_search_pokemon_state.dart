part of 'local_search_pokemon_bloc.dart';

class LocalSearchPokemonState extends Equatable {
  const LocalSearchPokemonState(this.pokemons);

  final List<PokemonModel> pokemons;

  // initial state
  factory LocalSearchPokemonState.initial() => LocalSearchPokemonState([]);

  // get filtered pokemon count
  int get filteredPokemonCount => pokemons.length;

  // Copy with method
  LocalSearchPokemonState copyWith({List<PokemonModel>? pokemons}) {
    return LocalSearchPokemonState(
      pokemons ?? this.pokemons,
    );
  }

  @override
  List<Object?> get props => [pokemons];
}
