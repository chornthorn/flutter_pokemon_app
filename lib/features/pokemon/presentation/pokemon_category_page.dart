import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/common/l10n/l10n.dart';

import '../application/get_pokemon_list/get_pokemon_list_bloc.dart';
import '../domain/pokemon_model.dart';
import 'pokemon_detail_page.dart';
import 'pokemon_page.dart';

class PokemonCategoryPage extends StatefulWidget {
  const PokemonCategoryPage({Key? key}) : super(key: key);

  static const String routeName = '/pokemon_category';

  @override
  State<PokemonCategoryPage> createState() => _PokemonCategoryPageState();
}

class _PokemonCategoryPageState extends State<PokemonCategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.l10n.topCategory,
                        style: Theme.of(context).textTheme.headline6),
                    // View all
                    TextButton(
                      onPressed: () {},
                      child: Text(context.l10n.viewAll,
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
                      return Row(
                        children: [
                          for (var i = 0; i < state.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: PokemonCardItem(
                                key: ValueKey(state[i].id),
                                title: state[i].name,
                                imageUrl: state[i].imageurl,
                                id: state[i].id,
                                type: state[i].category,
                                onTap: () {
                                  print('onTap');
                                  Navigator.pushNamed(
                                    context,
                                    PokemonDetailPage.routeName,
                                    arguments: {
                                      'id': state[i].id,
                                      'name': state[i].name,
                                      'imageUrl': state[i].imageurl,
                                      'type': state[i].category,
                                      'description': state[i].xdescription,
                                      'weaknesses': state[i].weaknesses,
                                      'height': state[i].height,
                                      'weight': state[i].weight,
                                      'speed': state[i].speed.toString(),
                                      'defense': state[i].defense.toString(),
                                      'attack': state[i].attack.toString(),
                                      'category': state[i].category,
                                      'typeofpokemon': state[i].typeofpokemon,
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LabelCategoryItem(title: "All", isSelected: true),
                      LabelCategoryItem(title: "Drowsing"),
                      LabelCategoryItem(title: "Synthetic"),
                      LabelCategoryItem(title: "Sea Cucumber"),
                      LabelCategoryItem(title: "Sand Castle"),
                      LabelCategoryItem(title: "Sand Heap"),
                      LabelCategoryItem(title: "Turn Tail"),
                      LabelCategoryItem(title: "Teamwork"),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    BlocSelector<GetPokemonListBloc, GetPokemonListState,
                        List<PokemonModel>>(
                      selector: (state) {
                        if (state is GetPokemonListLoaded) {
                          return state.data;
                        } else {
                          return [];
                        }
                      },
                      builder: (context, state) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: size.width < 500 ? 0.7 : 0.6,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            final pokemon = state[index];
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
                                    'description': pokemon.xdescription,
                                    'weaknesses': pokemon.weaknesses,
                                    'height': pokemon.height,
                                    'weight': pokemon.weight,
                                    'speed': pokemon.speed.toString(),
                                    'defense': pokemon.defense.toString(),
                                    'attack': pokemon.attack.toString(),
                                    'category': pokemon.category,
                                    'typeofpokemon': pokemon.typeofpokemon,
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LabelCategoryItem extends StatelessWidget {
  const LabelCategoryItem({
    Key? key,
    required this.title,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        // set color that can be changed by theme
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        // color: isSelected ? Colors.indigo : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            // set color that can be changed by theme
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
