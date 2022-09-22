import 'package:dartz/dartz.dart';

import '../domain/pokemon_model.dart';
import 'pokemon_service.dart';

abstract class PokemonRepository {
  Future<Either<String, List<PokemonModel>>> getPokemons();
}

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonService _service;

  PokemonRepositoryImpl(this._service);

  @override
  Future<Either<String, List<PokemonModel>>> getPokemons() async {
    try {
      final result = await _service.getPokemons();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
