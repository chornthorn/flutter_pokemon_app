part of 'favorite_pokemon_bloc.dart';

class FavoritePokemonState extends Equatable {
  const FavoritePokemonState(this.favoritePokemonIds);

  final List<int> favoritePokemonIds;

  // initial state
  factory FavoritePokemonState.initial() => const FavoritePokemonState([]);

  // add favorite pokemon
  FavoritePokemonState addFavoritePokemon(int pokemonId) {
    return FavoritePokemonState([...favoritePokemonIds, pokemonId]);
  }

  // remove favorite pokemon
  FavoritePokemonState removeFavoritePokemon(int pokemonId) {
    return FavoritePokemonState(
        favoritePokemonIds.where((id) => id != pokemonId).toList());
  }

  // check if pokemon is favorite
  bool isFavorite(int pokemonId) {
    return favoritePokemonIds.contains(pokemonId);
  }

  // get favorite pokemon count
  int get favoritePokemonCount => favoritePokemonIds.length;

  @override
  List<Object?> get props => [favoritePokemonIds];
}
