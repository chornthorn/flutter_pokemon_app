part of 'get_pokemon_list_bloc.dart';

abstract class GetPokemonListEvent extends Equatable {
  const GetPokemonListEvent();
}

class GetPokemonList extends GetPokemonListEvent {
  @override
  List<Object> get props => [];
}
