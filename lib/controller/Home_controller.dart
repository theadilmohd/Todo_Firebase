// controller/home_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mytodo/controller/add_task_controller.dart';
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

//   Future<void> deleteTask(String userId, ) async {
//      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//     try {
//       // DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
//       //     .collection("client")
//       //     .doc(userId)
//       //     .get();
//       // Map<String, dynamic> dataforDelete =
//       //     documentSnapshot.data() as Map<String, dynamic>;
//       // dataforDelete['task'].remove(0);
//     DocumentReference<Map<String, dynamic>> userDocRef =
//           _firestore.collection("users").doc(userId);

//       // Check if the document exists before proceeding
//       DocumentSnapshot<Map<String, dynamic>> userDoc = await userDocRef.get();
     
//       // Get the current tasks array from the document
//       List<Map<String, dynamic>> tasksList =
//           List.from(userDoc.data()?['tasks'] ?? []);

//       // Find and remove the map with the specified mapId
//       // tasksList.removeWhere((task) => task[1] == 1);

//       // Update the document with the modified tasks array
//       await userDocRef.update({
//         "tasks": tasksList,
//       });
//                                 // await FirebaseFirestore.instance
//                                 //     .collection('users')
//                                 //     .doc(userId)
                                
//                                 //     .update(
//                                 //   {
//                                 //     'task':
//                                 //         FieldValue.arrayRemove(
//                                 //       [0],
//                                 //     )
//                                 //   },
//                                 // );
//       // await FirebaseFirestore.instance.collection("client").doc(userId).
//     } catch (e) {
//       print("Error deleting task: $e");
//     }
//   }

//   //   void deleteTask(String documentId) {
//   //   FirebaseFirestore.instance.collection("client").doc(documentId);
//   // }
//   Future<void> editTask(String newTask, String uid) async {
//     await FirebaseFirestore.instance
//         .collection("client")
//         .doc(uid)
//         .update({'tasks': newTask});
//   }
// }
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class HomeController {
// //   var uid;

// //   HomeController(this.uid);

// //   void deleteTask(String documentId) {
// //     FirebaseFirestore.instance.collection("client").doc(uid).update({
// //       "tasks": FieldValue.arrayRemove([/* Task to be deleted */]),
// //     });
// //   }

// //   void editTask(String documentId, String editedTask) {
// //     FirebaseFirestore.instance.collection("client").doc(uid).update({
// //       "tasks": FieldValue.arrayUnion([{"task": editedTask}]),
// //     });
// //   }
 }
