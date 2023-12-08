// views/add_task_view.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/View/home_Screen.dart';
import 'package:mytodo/View/todo_view.dart';
//import 'package:intl/intl.dart';
//import 'package:mytodo/View/todo_view.dart';
import 'package:mytodo/controller/add_task_controller.dart';
//import 'package:mytodo/controllers/add_task_controller.dart';

class AddTaskView extends StatelessWidget {  
  final AddTaskController addTaskController = AddTaskController();
  final taskName = TextEditingController();
  final subTaskName = TextEditingController();
  final date = TextEditingController();
  final time = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Text('Add your tasks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            // Widget code...
            //  Padding(
            // padding: EdgeInsets.all(15),
            // child: Column(
            //   children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: taskName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Task',
                  hintText: 'Enter Your Task',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: subTaskName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your User Subtask',
                  hintText: 'Enter Your Subtask',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: date,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date',
                  hintText: 'yyyy-MM-dd',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: time,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time',
                  hintText: 'HH:mm',
                ),
              ),
            ),
            //

            ElevatedButton(
              onPressed: () async {
                addTaskController.addTask(
                    taskName.text, subTaskName.text, date.text, time.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
