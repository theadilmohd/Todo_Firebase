 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AddTaskController {
  Future<void> addTask(
      String taskName, String subTaskName, String date, String time) async {
    try {
      if (taskName.isEmpty ||
          subTaskName.isEmpty ||
          date.isEmpty ||
          time.isEmpty) {
        print("Please fill in all fields");
        return;
      }

      String dateTimeString = '$date $time';
      DateTime dateTime = DateFormat('MM/dd/yyyy HH:mm').parse(dateTimeString);
      Timestamp timestamp = Timestamp.fromDate(dateTime);

      var taskData = {
        'task': taskName,
        'subTask': subTaskName,
        'timestamp': timestamp,
      };

      var uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        var collRef = FirebaseFirestore.instance.collection('client').doc(uid);

        // Check if the document for the user exists
        var userDoc = await collRef.get();
        if (!userDoc.exists) {
          // If the document doesn't exist, create it with an empty 'tasks' list
          await collRef.set({'tasks': []});
        }

        // Get the current list of tasks from the user's document
        var tasksList = (userDoc.data()?['tasks'] ?? []) as List<dynamic>;

        // Add the new task to the list as a map
        tasksList.add(taskData);

        // Update the 'tasks' field with the modified list
        await collRef.update({'tasks': tasksList});

        print("Data added successfully!");
      } else {
        print("User not authenticated.");
      }
    } catch (e) {
      print("Error adding data: $e");
    }
  }
}


