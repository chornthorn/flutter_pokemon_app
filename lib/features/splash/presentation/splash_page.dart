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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
