import 'package:flutter/material.dart';
import 'package:pokemon_app/bootstrap.dart';
import 'package:pokemon_app/features/app/app.dart';
import 'package:pokemon_app/features/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializationDependencies();
  bootstrap(() => const AppIndex());
}
