part of 'filter_pokemon_bloc.dart';

abstract class FilterPokemonEvent extends Equatable {
  const FilterPokemonEvent();
}

class FilterPokemon extends FilterPokemonEvent {
  final String filter;
  final List<PokemonModel> pokemon;

  const FilterPokemon({required this.filter, required this.pokemon});

  @override
  List<Object> get props => [filter, pokemon];
}

// filter get only favorite pokemon
class FilterFavoritePokemon extends FilterPokemonEvent {
  final List<PokemonModel> pokemon;
  final List<int> favoritePokemonIds;

  const FilterFavoritePokemon(
      {required this.pokemon, required this.favoritePokemonIds});

  @override
  List<Object> get props => [pokemon, favoritePokemonIds];
}

class ClearFilter extends FilterPokemonEvent {
  @override
  List<Object> get props => [];
}
