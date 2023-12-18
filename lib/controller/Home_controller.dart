// controller/home_controller.dart
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:mytodo/controller/add_task_controller.dart';
import 'package:mytodo/model/user_model.dart';
//import 'package:mytodo/models/user_model.dart';

class HomeController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  set uid(uid) {}

  UserModel getCurrentUser() {
    
    final user = _firebaseAuth.currentUser;
    return UserModel(
      displayName: user!.displayName ?? 'User',
      photoURL: user.photoURL ?? 'https://example.com/default-image.jpg',
    );
  }
 }
