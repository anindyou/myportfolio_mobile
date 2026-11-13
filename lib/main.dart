import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/menu.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.cascadiaCodeTextTheme(
          const TextTheme(
            titleLarge: TextStyle(fontSize: 32.0),
            bodyLarge: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

