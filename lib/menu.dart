import 'package:flutter/material.dart';

// Warna
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF13111B);
  static const Color pink = Color(0xFFFF79C6);
  static const Color green = Color(0xFF67E480);
  static const Color purple = Color(0xFF988BC7);
  static const Color darkYellow = Color(0xFFFFD700);
  static const Color lightYellow = Color(0xFFE7DE79);
  static const Color white = Color(0xFFD9D9D9);
  static const Color blue = Color(0xFF33C1D5);
  static const Color surface = Color(0xFF1B1827);
  static const Color red = Color(0xFFFF4D66);
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

