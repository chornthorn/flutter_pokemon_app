part of 'get_pokemon_list_bloc.dart';

abstract class GetPokemonListState extends Equatable {
  const GetPokemonListState();
}

class GetPokemonListInitial extends GetPokemonListState {
  @override
  List<Object> get props => [];
}

class GetPokemonListLoading extends GetPokemonListState {
  @override
  List<Object> get props => [];
}

class GetPokemonListLoaded extends GetPokemonListState {
  final List<PokemonModel> data;

  GetPokemonListLoaded(this.data);

  @override
  List<Object> get props => [data];
}

// failure
class GetPokemonListFailure extends GetPokemonListState {
  final String message;

  GetPokemonListFailure(this.message);

  @override
  List<Object> get props => [message];
}
