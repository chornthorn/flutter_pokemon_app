import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/pokemon_model.dart';
import '../../infrastructure/pokemon_repository.dart';

part 'get_pokemon_list_event.dart';
part 'get_pokemon_list_state.dart';

class GetPokemonListBloc
    extends Bloc<GetPokemonListEvent, GetPokemonListState> {
  GetPokemonListBloc(this._pokemonRepository) : super(GetPokemonListInitial()) {
    on<GetPokemonList>(_onGetPokemonList);
  }

  final PokemonRepository _pokemonRepository;

  FutureOr<void> _onGetPokemonList(
      GetPokemonList event, Emitter<GetPokemonListState> emit) async {
    try {
      emit(GetPokemonListLoading());
      final result = await _pokemonRepository.getPokemons();
      result.fold(
        (failure) => emit(GetPokemonListFailure(failure)),
        (pokemons) => emit(GetPokemonListLoaded(pokemons)),
      );
    } catch (e) {
      emit(GetPokemonListFailure("Something went wrong"));
    }
  }
}
