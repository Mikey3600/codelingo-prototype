import 'package:flutter/material.dart';
import 'config/theme_config.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const CodeLingoApp());
}

class CodeLingoApp extends StatelessWidget {
  const CodeLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeLingo',
      debugShowCheckedModeBanner: false,
      // Use Flutter's built-in themes if ThemeConfig is not defined
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
