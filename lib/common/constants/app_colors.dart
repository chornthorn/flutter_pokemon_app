import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';

class AppColors {
  AppColors._();
  static const white = Colors.white;
  static final secondary =
      generateMaterialColor(color: const Color(0xFF797979));
  static final greyScale = generateMaterialColor(
    color: Colors.black,
  );
  static final primary = generateMaterialColor(
    color: const Color(0xffe101010),
  );
}
