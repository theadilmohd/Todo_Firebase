// settings_page.dart
import 'package:flutter/material.dart';
import 'package:mytodo/View/settings_view.dart';
//import 'package:mytodo/views/login_page.dart';
import 'package:mytodo/providers/theme_provider.dart';
//import 'package:mytodo/view_models/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final viewModel = SettingsViewModel(themeProvider: themeProvider);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          ElevatedButton(
            onPressed: () => viewModel.signOut(context),
            child: const Text('Sign Out'),
          ),
          const SizedBox(height: 10,),
          SwitchListTile(
            title: const Text('Dark Theme'),
            onChanged: (value) {
              viewModel.themeProvider.toggleTheme();
            },
            value: themeProvider.isDarkMode,
          ),
        ],
      ),
    );
  }
}
