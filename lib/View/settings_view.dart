// settings_view_model.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytodo/View/login_page.dart';
import 'package:mytodo/providers/theme_provider.dart';

class SettingsViewModel extends ChangeNotifier {
  final ThemeProvider themeProvider;

  SettingsViewModel({required this.themeProvider});

  void signOut(BuildContext context) {
    try {
      // Use this to Log Out user
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
    } on Exception catch (e) {
      print(e);
    }
  }
}
