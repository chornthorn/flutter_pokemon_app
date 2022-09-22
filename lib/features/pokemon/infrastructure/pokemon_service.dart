import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pokemon_app/common/exceptions/bad_request_api_exception.dart';
import 'package:pokemon_app/common/networks/http_client.dart';
import 'package:pokemon_app/features/pokemon/domain/pokemon_model.dart';

class PokemonService {
  final HttpService _http;

  PokemonService(this._http);

  Future<List<PokemonModel>> getPokemons() async {
    try {
      final response = await _http
          .read('/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json');
      final pokemons = json.decode(response.data) as List;
      // limited to 10 pokemons
      return pokemons.map((e) => PokemonModel.fromJson(e)).take(20).toList();
    } on SocketException {
      throw BadRequestApiException('No Internet Connection');
    } catch (e) {
      throw BadRequestApiException("Something went wrong");
    }
  }

  // create compute function
  Future<List<PokemonModel>> getPokemonsWithCompute() async {
    try {
      final response = await _http.read('/pokemon.json');
      final pokemons = response.data as List;
      // limite only 10 pokemons
      final pokemonsLimited = pokemons.take(10).toList();
      // run in background
      return await compute(_parsePokemons, pokemonsLimited);
    } on SocketException {
      throw BadRequestApiException('No Internet Connection');
    } catch (e) {
      throw BadRequestApiException("Something went wrong");
    }
  }

  // parse pokemons
  static List<PokemonModel> _parsePokemons(List pokemons) {
    return pokemons.map((e) => PokemonModel.fromJson(e)).toList();
  }
}
