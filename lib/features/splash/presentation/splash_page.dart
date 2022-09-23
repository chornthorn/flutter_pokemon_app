import 'package:flutter/material.dart';
import 'package:pokemon_app/features/app/presentation/main_page.dart';
import 'package:pokemon_app/features/injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getIt.allReady().then((_) {
      Navigator.of(context).pushReplacementNamed(MainPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Spacer(flex: 3),
          Image.asset(
            'assets/img/pngegg.png',
            height: 250,
            width: 250,
          ),
          Spacer(flex: 2),
          const SizedBox(height: 16),

          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
