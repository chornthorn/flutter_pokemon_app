part of 'favorite_pokemon_bloc.dart';

abstract class FavoritePokemonEvent extends Equatable {
  const FavoritePokemonEvent();
}

class AddFavoritePokemon extends FavoritePokemonEvent {
  final int pokemonId;

  const AddFavoritePokemon(this.pokemonId);

  @override
  List<Object> get props => [pokemonId];
}

class RemoveFavoritePokemon extends FavoritePokemonEvent {
  final int pokemonId;

  const RemoveFavoritePokemon(this.pokemonId);

  @override
  List<Object> get props => [pokemonId];
}
