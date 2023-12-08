import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodo/View/add_task_view.dart';
import 'package:mytodo/controller/Home_controller.dart';
import 'package:mytodo/model/user_model.dart';

class TodoView extends StatefulWidget {
  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  var uid;

  final HomeController homeController = HomeController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser?.uid;
    super.initState();
    homeController.uid = uid;
  }

  void onEdit(String documentId, TaskModel task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskView(documentId: documentId, task: task),
      ),
    ).then((editedTask) {
      if (editedTask != null) {
        _updateTask(documentId, task, editedTask);
      }
    });
  }

  void _updateTask(String documentId, TaskModel oldTask, TaskModel newTask) async {
    try {
      await FirebaseFirestore.instance
          .collection("client")
          .doc(uid)
          .update({
        'tasks': FieldValue.arrayRemove([
          {
            'task': oldTask.task,
            'subTask': oldTask.subTask,
            'timestamp': oldTask.timestamp,
          }
        ])
      });

      await FirebaseFirestore.instance
          .collection("client")
          .doc(uid)
          .update({
        'tasks': FieldValue.arrayUnion([
          {
            'task': newTask.task,
            'subTask': newTask.subTask,
            'timestamp': newTask.timestamp,
          }
        ])
      });

      setState(() {});
    } catch (e) {
      print("Error updating task: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("client").doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            var tasksData = snapshot.data?.data() ?? {};
            List tasksList = tasksData['tasks'] ?? [];

            List filteredTasks = tasksList.where((task) {
              String taskName = task["task"].toString().toLowerCase();
              String searchQuery = searchController.text.toLowerCase();
              return taskName.contains(searchQuery);
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Your Tasks........',
                    ),
                    onChanged: (query) {
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      String documentId = snapshot.data!.id;
                      Map<String, dynamic>? data =
                          filteredTasks[index] as Map<String, dynamic>?;
                      TaskModel task = TaskModel(
                        task: data?["task"] ?? "",
                        subTask: data?["subTask"] ?? "",
                        timestamp: data?["timestamp"] != null
                            ? (data?["timestamp"] as Timestamp).toDate()
                            : null,
                      );

                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1 - 5,
                          height: 200,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            task.task,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(255, 173, 25, 153),
                                            ),
                                          ),
                                        ),
                                      ),
                                      PopupMenuButton<String>(
                                        onSelected: (value) {
                                          if (value == 'delete') {
                                            _deleteTask(documentId, task);
                                          } else if (value == 'edit') {
                                            onEdit(documentId, task);
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Text(
                                    task.subTask,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      task.timestamp != null
                                          ? DateFormat('dd-MM-yyyy')
                                              .format(task.timestamp!)
                                          : 'No date',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('HH:mm').format(task.timestamp!),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskView()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _deleteTask(String documentId, TaskModel task) async {
    try {
      await FirebaseFirestore.instance
          .collection("client")
          .doc(uid)
          .update({
        'tasks': FieldValue.arrayRemove([
          {
            'task': task.task,
            'subTask': task.subTask,
            'timestamp': task.timestamp,
          }
        ])
      });
      setState(() {});
    } catch (e) {
      print("Error deleting task: $e");
    }
  }
}

// EditTaskView...
class EditTaskView extends StatefulWidget {
  final String documentId;
  final TaskModel task;

  const EditTaskView({required this.documentId, required this.task});

  @override
  _EditTaskViewState createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  late TextEditingController taskController;
  late TextEditingController subTaskController;

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController(text: widget.task.task);
    subTaskController = TextEditingController(text: widget.task.subTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Task',
              border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50,),
            TextField(
              controller: subTaskController,
              decoration: InputDecoration(labelText: 'Subtask',
              border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                TaskModel editedTask = TaskModel(
                  task: taskController.text,
                  subTask: subTaskController.text,
                  timestamp: widget.task.timestamp,
                );
                Navigator.pop(context, editedTask);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
