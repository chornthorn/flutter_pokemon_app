import 'package:flutter/material.dart';
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
                    Text("Top Category",
                        style: Theme.of(context).textTheme.headline6),
                    // View all
                    TextButton(
                      onPressed: () {},
                      child: const Text('View all'),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // PokemonCardItem(index: 80),
                      // const SizedBox(width: 12),
                      // PokemonCardItem(index: 1),
                      // const SizedBox(width: 12),
                      // PokemonCardItem(index: 1),
                      // const SizedBox(width: 12),
                      // PokemonCardItem(index: 90),
                    ],
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
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: size.width < 500 ? 0.7 : 0.6,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        // return PokemonCardItem(
                        //   index: index + 1,
                        // );
                        return Container();
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
