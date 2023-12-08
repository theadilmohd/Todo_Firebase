import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mytodo/View/home_Screen.dart';
//import 'package:mytodo/example.dart';
import 'package:mytodo/firebase_options.dart';
//import 'package:mytodo/home_screen.dart';
import 'package:mytodo/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'View/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'Firebase App',
              theme: ThemeData(
                primarySwatch: Colors.red,
                brightness: 
                themeProvider.isDarkMode ? 
                Brightness.dark :
                 Brightness.light,
              ),
              home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HomeScreen();
                  } else {
                    return LoginPage();
                  }
                },
              ),
              // theme: ThemeData(
              //   primarySwatch: Colors.blue,
              // ),
              //    home: LoginPage(),
            );
          },
        )
        );
  }
}
