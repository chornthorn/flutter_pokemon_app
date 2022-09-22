import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/features/pokemon/domain/pokemon_model.dart';

part 'filter_pokemon_event.dart';

part 'filter_pokemon_state.dart';

class FilterPokemonBloc extends Bloc<FilterPokemonEvent, FilterPokemonState> {
  FilterPokemonBloc() : super(FilterPokemonState.initial()) {
    on<FilterPokemon>(_onFilterPokemon);
    on<FilterFavoritePokemon>(_onFilterFavoritePokemon);
    on<ClearFilter>(_onClearFilter);
  }

  FutureOr<void> _onFilterPokemon(
      FilterPokemon event, Emitter<FilterPokemonState> emit) {
// filter pokemon
    final filteredPokemon = event.pokemon
        .where((pokemon) =>
            pokemon.category.toLowerCase().contains(event.filter.toLowerCase()))
        .toList();

    // emit new state
    emit(state.copyWith(filteredPokemon: filteredPokemon));
  }

  FutureOr<void> _onFilterFavoritePokemon(
      FilterFavoritePokemon event, Emitter<FilterPokemonState> emit) {
    // before filtering with id we remove # from id in pokemon model first
    final filteredPokemon = event.pokemon
        .where((pokemon) => event.favoritePokemonIds
            .contains(int.parse(pokemon.id.replaceAll('#', ''))))
        .toList();

    // emit new state
    emit(state.copyWith(filteredPokemon: filteredPokemon));
  }

  FutureOr<void> _onClearFilter(
      ClearFilter event, Emitter<FilterPokemonState> emit) {
    emit(state.copyWith(filteredPokemon: []));
  }
}
