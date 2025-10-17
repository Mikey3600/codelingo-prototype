import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeNotifier>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: Text(theme.themeMode.name),
            trailing: DropdownButton<ThemeMode>(
              value: theme.themeMode,
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (value) {
                if (value != null) theme.setThemeMode(value);
              },
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Enable animations'),
            value: true,
            onChanged: (v) {},
          ),
        ],
      ),
    );
  }
}
