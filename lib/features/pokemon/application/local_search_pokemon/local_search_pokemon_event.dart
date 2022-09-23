part of 'local_search_pokemon_bloc.dart';

abstract class LocalSearchPokemonEvent extends Equatable {
  const LocalSearchPokemonEvent();
}

class LocalSearchPokemon extends LocalSearchPokemonEvent {
  final String query;
  final List<PokemonModel> pokemons;

  const LocalSearchPokemon({required this.query, required this.pokemons});

  @override
  List<Object> get props => [query, pokemons];
}
