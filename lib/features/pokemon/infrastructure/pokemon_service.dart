import 'dart:io';

import 'package:pokemon_app/common/exceptions/bad_request_api_exception.dart';
import 'package:pokemon_app/common/networks/http_client.dart';
import 'package:pokemon_app/features/pokemon/domain/pokemon_model.dart';

class PokemonService {
  final HttpService _http;

  PokemonService(this._http);

  Future<List<PokemonModel>> getPokemons() async {
    try {
      final response = await _http.get('/pokemon');
      final pokemons = response.data as List;
      return pokemons.map((e) => PokemonModel.fromJson(e)).toList();
    } on SocketException {
      throw BadRequestApiException('No Internet Connection');
    } catch (e) {
      throw BadRequestApiException("Something went wrong");
    }
  }
}
