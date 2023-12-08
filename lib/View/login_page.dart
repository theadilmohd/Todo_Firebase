import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodo/View/home_Screen.dart';
import 'package:mytodo/View/todo_view.dart';
import 'package:mytodo/controller/google_signin.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//import 'package:mytodo/home_screen.dart';


class LoginPage extends StatelessWidget {
  final AuthController authController = AuthController();

  LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'My Todo',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 56,
                  color: Colors.white),
            ),
            // ElevatedButton.icon(onPressed: (){}, icon:Image.asset('assets/google (1).png',scale: 20,), label: Text('hkkj')),
            GestureDetector(
              onTap: () async {
                UserCredential? userCredential = await authController.handleSignIn(context);
                if (userCredential != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HomeScreen(),
                    ),
                  );
                }
              },
              child: Image.asset(
                'assets/google (1).png',
                scale: 10, // Replace with your image asset path
                width: 150.0,
                height: 150.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
