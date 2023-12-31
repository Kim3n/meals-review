import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';

/// The theme used throughout the app.
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 119, 11, 146),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

/// The root widget of the Meals App.
class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    ));
  }
}
