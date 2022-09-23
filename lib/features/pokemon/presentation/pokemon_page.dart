import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/common/l10n/l10n.dart';
import 'package:pokemon_app/features/pokemon/application/filter_pokemon/filter_pokemon_bloc.dart';
import 'package:pokemon_app/features/pokemon/application/local_search_pokemon/local_search_pokemon_bloc.dart';
import 'package:pokemon_app/features/pokemon/domain/pokemon_model.dart';

import '../application/favorite_pokemon/favorite_pokemon_bloc.dart';
import '../application/get_pokemon_list/get_pokemon_list_bloc.dart';
import 'pokemon_detail_page.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key}) : super(key: key);

  static const String routeName = '/pokemon';

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;
  var showScrollTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 300) {
        setState(() {
          showScrollTopButton = true;
        });
      } else {
        setState(() {
          showScrollTopButton = false;
        });
      }
    });
    BlocProvider.of<GetPokemonListBloc>(context).add(GetPokemonList());
  }

  String? filter;

  // show filter dialog
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.l10n.filter),
          content: _FilterFavoriteWidget(
            value: filter ?? "No",
            onChanged: (value) {
              setState(() {
                filter = value;
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    super.build(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: showScrollTopButton
            ? FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: const Icon(Icons.arrow_upward),
              )
            : null,
        body: Column(
          children: <Widget>[
            // Container with shadow
            if (!showScrollTopButton) _buildSearchBox(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            context.l10n.filter,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // filter icon
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            splashRadius: 20,
                            onPressed: () {
                              _showFilterDialog();
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<GetPokemonListBloc, GetPokemonListState>(
                      builder: (context, state) {
                        if (state is GetPokemonListLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetPokemonListLoaded) {
                          // create list of pokemon local list
                          final pokemonList = state.data;

                          return BlocSelector<FilterPokemonBloc,
                              FilterPokemonState, List<PokemonModel>>(
                            selector: (state) {
                              if (state.filteredPokemon.length > 0) {
                                return state.filteredPokemon;
                              } else {
                                return pokemonList;
                              }
                            },
                            builder: (context, filterState) {
                              return BlocSelector<LocalSearchPokemonBloc,
                                  LocalSearchPokemonState, List<PokemonModel>>(
                                selector: (state) {
                                  if (state.pokemons.length > 0) {
                                    return state.pokemons;
                                  } else {
                                    return filterState;
                                  }
                                },
                                builder: (context, localSearchState) {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      // make responsive for iphone devices base [size]
                                      childAspectRatio:
                                          size.width < 500 ? 0.7 : 0.6,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    itemCount: localSearchState.length,
                                    itemBuilder: (context, index) {
                                      // get pokemon from local list
                                      final pokemon = localSearchState[index];
                                      return PokemonCardItem(
                                        key: ValueKey(pokemon.id),
                                        title: pokemon.name,
                                        imageUrl: pokemon.imageurl,
                                        id: pokemon.id,
                                        type: pokemon.category,
                                        onTap: () {
                                          print('onTap');
                                          Navigator.pushNamed(
                                            context,
                                            PokemonDetailPage.routeName,
                                            arguments: {
                                              'id': pokemon.id,
                                              'name': pokemon.name,
                                              'imageUrl': pokemon.imageurl,
                                              'type': pokemon.category,
                                              'description':
                                                  pokemon.xdescription,
                                              'weaknesses': pokemon.weaknesses,
                                              'height': pokemon.height,
                                              'weight': pokemon.weight,
                                              'speed': pokemon.speed.toString(),
                                              'defense':
                                                  pokemon.defense.toString(),
                                              'attack':
                                                  pokemon.attack.toString(),
                                              'category': pokemon.category,
                                              'typeofpokemon':
                                                  pokemon.typeofpokemon,
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _FilterFavoriteWidget extends StatefulWidget {
  const _FilterFavoriteWidget(
      {Key? key, required this.onChanged, required this.value})
      : super(key: key);

  final ValueChanged<String> onChanged;
  final String value;

  @override
  State<_FilterFavoriteWidget> createState() => _FilterFavoriteWidgetState();
}

class _FilterFavoriteWidgetState extends State<_FilterFavoriteWidget> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text('Favorite'),
            const Spacer(),
            BlocSelector<GetPokemonListBloc, GetPokemonListState,
                List<PokemonModel>>(
              selector: (state) {
                if (state is GetPokemonListLoaded) {
                  return state.data;
                } else {
                  return [];
                }
              },
              builder: (context, pokemonListState) {
                return BlocSelector<FavoritePokemonBloc, FavoritePokemonState,
                    FavoritePokemonState>(
                  selector: (state) {
                    return state;
                  },
                  builder: (context, state) {
                    return DropdownButton<String>(
                      value: _selectedValue,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Yes'),
                          value: 'Yes',
                        ),
                        DropdownMenuItem(
                          child: Text('No'),
                          value: 'No',
                        ),
                      ],
                      onChanged: (value) {
                        widget.onChanged(value!);
                        setState(() {
                          _selectedValue = value;
                        });
                        if (value == 'Yes') {
                          BlocProvider.of<FilterPokemonBloc>(context).add(
                            FilterFavoritePokemon(
                              pokemon: pokemonListState,
                              favoritePokemonIds: state.favoritePokemonIds,
                            ),
                          );
                        } else {
                          BlocProvider.of<FilterPokemonBloc>(context).add(
                            FilterFavoritePokemon(
                              pokemon: pokemonListState,
                              favoritePokemonIds: [],
                            ),
                          );
                        }
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class PokemonCardItem extends StatelessWidget {
  const PokemonCardItem({
    Key? key,
    this.onTap,
    required this.title,
    required this.id,
    required this.imageUrl,
    required this.type,
  }) : super(key: key);

  final String title;
  final String id;
  final String imageUrl;
  final String type;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minWidth: 160, minHeight: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 0.5,
              offset: Offset(5, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // favorite icon
            BlocSelector<FavoritePokemonBloc, FavoritePokemonState,
                FavoritePokemonState>(
              selector: (state) {
                return state;
              },
              builder: (context, state) {
                // remove first character '#' from id
                final id = this.id.substring(1);
                return Align(
                  alignment: Alignment.topRight,
                  child: BlocSelector<GetPokemonListBloc, GetPokemonListState,
                      List<PokemonModel>>(
                    selector: (state) {
                      if (state is GetPokemonListLoaded) {
                        return state.data;
                      } else {
                        return [];
                      }
                    },
                    builder: (context, pokemonState) {
                      return GestureDetector(
                        onTap: () {
                          if (state.favoritePokemonIds
                              .contains(int.parse(id))) {
                            BlocProvider.of<FavoritePokemonBloc>(context)
                                .add(RemoveFavoritePokemon(int.parse(id)));
                          } else {
                            BlocProvider.of<FavoritePokemonBloc>(context)
                                .add(AddFavoritePokemon(int.parse(id)));
                          }
                        },
                        child: Icon(
                          Icons.favorite_border,
                          color:
                              state.favoritePokemonIds.contains(int.parse(id))
                                  ? Colors.red
                                  : Colors.grey,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // Image
            Center(
              child: Image.network(
                imageUrl,
                height: 100,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ID:"),
                    Text(
                      id,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                // category
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Type: "),
                    Text(
                      type,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _buildSearchBox extends StatelessWidget {
  const _buildSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocSelector<GetPokemonListBloc, GetPokemonListState,
          List<PokemonModel>>(
        selector: (state) {
          if (state is GetPokemonListLoaded) {
            return state.data;
          } else {
            return [];
          }
        },
        builder: (context, state) {
          return TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: context.l10n.search,
              prefixIcon: Icon(Icons.search),
              contentPadding: const EdgeInsets.all(16),
              constraints: const BoxConstraints(
                maxHeight: 56,
              ),
              isDense: true,
            ),
            onChanged: (value) {
              print(value);
              BlocProvider.of<LocalSearchPokemonBloc>(context).add(
                LocalSearchPokemon(
                  pokemons: state,
                  query: value,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
