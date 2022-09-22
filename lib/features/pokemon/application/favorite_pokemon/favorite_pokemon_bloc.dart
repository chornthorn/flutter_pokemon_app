import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_pokemon_event.dart';

part 'favorite_pokemon_state.dart';

class FavoritePokemonBloc
    extends Bloc<FavoritePokemonEvent, FavoritePokemonState> {
  FavoritePokemonBloc() : super(FavoritePokemonState.initial()) {
    on<AddFavoritePokemon>(_onAddFavoritePokemon);
    on<RemoveFavoritePokemon>(_onRemoveFavoritePokemon);
  }

  FutureOr<void> _onAddFavoritePokemon(
      AddFavoritePokemon event, Emitter<FavoritePokemonState> emit) {
    // check if pokemon is already favorite or not before adding
    if (!state.isFavorite(event.pokemonId)) {
      emit(state.addFavoritePokemon(event.pokemonId));
    }
  }

  FutureOr<void> _onRemoveFavoritePokemon(
      RemoveFavoritePokemon event, Emitter<FavoritePokemonState> emit) {
    // check if pokemon is already favorite or not before removing
    if (state.isFavorite(event.pokemonId)) {
      emit(state.removeFavoritePokemon(event.pokemonId));
    }
  }
}
