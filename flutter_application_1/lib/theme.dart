import 'package:flutter/material.dart';

const Color navy = Color(0xFF102A43);
const Color blue = Color(0xFF1976D2);
const Color green = Color(0xFF2E7D32);
const Color muted = Color(0xFF78909C);
const Color line = Color(0xFFE0E7EF);
const Color background = Color(0xFFF5F8FC);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: blue,
  ),
);
// TODO Implement this library.