import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_app/features/pokemon/domain/pokemon_model.dart';
import 'package:stream_transform/stream_transform.dart';

part 'local_search_pokemon_event.dart';

part 'local_search_pokemon_state.dart';

const _duration = const Duration(milliseconds: 1000);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class LocalSearchPokemonBloc
    extends Bloc<LocalSearchPokemonEvent, LocalSearchPokemonState> {
  LocalSearchPokemonBloc() : super(LocalSearchPokemonState.initial()) {
    on<LocalSearchPokemon>(_onLocalSearchPokemon,
        transformer: debounce(_duration));
  }

  FutureOr<void> _onLocalSearchPokemon(
      LocalSearchPokemon event, Emitter<LocalSearchPokemonState> emit) {
    // filter pokemon
    final filteredPokemon = event.pokemons.where((pokemon) => pokemon.name.toLowerCase().contains(event.query.toLowerCase())).toList();

    // emit new state
    emit(state.copyWith(pokemons: filteredPokemon));
  }
}
