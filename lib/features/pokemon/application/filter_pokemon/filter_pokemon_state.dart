part of 'filter_pokemon_bloc.dart';

class FilterPokemonState extends Equatable {
  const FilterPokemonState({required this.filteredPokemon});

  final List<PokemonModel> filteredPokemon;

  // initial state
  factory FilterPokemonState.initial() =>
      const FilterPokemonState(filteredPokemon: []);

  // get filtered pokemon count
  int get filteredPokemonCount => filteredPokemon.length;

  // Copy with method
  FilterPokemonState copyWith({List<PokemonModel>? filteredPokemon}) {
    return FilterPokemonState(
      filteredPokemon: filteredPokemon ?? this.filteredPokemon,
    );
  }

  @override
  List<Object?> get props => [filteredPokemon];
}
