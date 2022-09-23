import 'package:flutter/material.dart';
import 'package:pokemon_app/common/l10n/l10n.dart';

import '../../pokemon/presentation/pokemon_category_page.dart';
import '../../pokemon/presentation/pokemon_page.dart';
import '../../settings/presentation/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PokemonPage(),
    PokemonCategoryPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body should be keep alive to prevent state reset
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: context.l10n.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: context.l10n.catalog,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: context.l10n.settings,
          ),
        ],
        // this will be set when a new tab is tapped
        currentIndex: _selectedIndex,
        // this will be set when a new tab is tapped
        onTap: _onItemTapped,
        selectedFontSize: 14,
        unselectedFontSize: 14,
      ),
    );
  }
}
