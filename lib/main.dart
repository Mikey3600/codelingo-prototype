import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'config/theme_config.dart';
import 'screens/home/home_screen.dart';
import 'config/router.dart';
import 'services/snackbar_service.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString('theme_mode');
    if (mode != null) {
      _themeMode = _fromString(mode);
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _toString(mode));
  }

  String _toString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
      default:
        return 'system';
    }
  }

  ThemeMode _fromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeNotifier = ThemeNotifier();
  await themeNotifier.load();
  final prefs = await SharedPreferences.getInstance();
  final isOnboarded = prefs.getBool('onboarded') ?? false;
  final router = createRouter(isOnboarded: isOnboarded);
  runApp(
    ChangeNotifierProvider(
      create: (_) => themeNotifier,
      child: CodeLingoApp(router: router),
    ),
  );
}

class CodeLingoApp extends StatelessWidget {
  final GoRouter router;
  const CodeLingoApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return MaterialApp.router(
      title: 'CodeLingo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: theme.themeMode,
      routerConfig: router,
      scaffoldMessengerKey: SnackbarService.messengerKey,
    );
  }
}
