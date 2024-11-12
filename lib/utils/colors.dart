// colors.dart
import 'package:flutter/material.dart';

class CafeColors {
  static const MaterialColor Cafe = MaterialColor(
    _brownPrimaryValue,
    <int, Color>{
      50: Color(0xFFFEFEF9),
      100: Color(0xFFF7CCC8),
      200: Color(0xFFFBCAA4),
      300: Color(0xFFA1887F),
      400: Color(0xFFF8D6E3),
      500: Color(_brownPrimaryValue),
      600: Color(0xFF6D4C41),
      700: Color(0xFF5D4037),
      800: Color(0xFF4E342E),
      900: Color(0xFF3E2723),
    },
  );

  static const int _brownPrimaryValue = 0xFF795548;
}
