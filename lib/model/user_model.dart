// models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String displayName;
  final String photoURL;

  UserModel({required this.displayName, required this.photoURL});
}
// models/task_model.dart
class TaskModel {
  final String task;
  final String subTask;
  final DateTime? timestamp;

  TaskModel({
    required this.task,
    required this.subTask,
    required this.timestamp,
  });
    factory TaskModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
     if (data == null) {
    // Handle the case where data is null (or any other appropriate action)
    throw Exception("Data is null in TaskModel.fromSnapshot");
  }
    
    return TaskModel(
      task: data['task'] ?? '',
      subTask: data['subTask'] ?? '',
     timestamp: (data['timestamp'] as Timestamp?)!.toDate() ?? DateTime.now(),
      // DateTime.now(),
    );
  }
}
// models/group_model.dart
class GroupModel {
  final String groupName;

  GroupModel({required this.groupName});
}
