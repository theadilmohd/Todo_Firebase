// // views/add_task_view.dart
// //import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mytodo/View/home_Screen.dart';
// //import 'package:mytodo/View/todo_view.dart';
// //import 'package:intl/intl.dart';
// //import 'package:mytodo/View/todo_view.dart';
// import 'package:mytodo/controller/add_task_controller.dart';
// //import 'package:mytodo/controllers/add_task_controller.dart';

// class AddTaskView extends StatelessWidget {  
//   final AddTaskController addTaskController = AddTaskController();
//   final taskName = TextEditingController();
//   final subTaskName = TextEditingController();
//   final date = TextEditingController();
//   final time = TextEditingController(); 

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 50,),
//             Text('Add your tasks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
//             // Widget code...
//             //  Padding(
//             // padding: EdgeInsets.all(15),
//             // child: Column(
//             //   children: <Widget>[
//             SizedBox(
//               height: 100,
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: taskName,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Your Task',
//                   hintText: 'Enter Your Task',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: subTaskName,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Your User Subtask',
//                   hintText: 'Enter Your Subtask',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: date,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Date',
//                   hintText: 'dd/MM/yyyy',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(15),
//               child: TextField(
//                 controller: time,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Time',
//                   hintText: 'HH:mm',
//                 ),
//               ),
//             ),
//             //

//             ElevatedButton(
//               onPressed: () async {
//                 addTaskController.addTask(
//                     taskName.text, subTaskName.text, date.text, time.text);
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomeScreen()));
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
//               ),
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodo/View/home_Screen.dart';
import 'package:mytodo/controller/add_task_controller.dart';

class AddTaskView extends StatelessWidget {
  final AddTaskController addTaskController = AddTaskController();
  final taskName = TextEditingController();
  final subTaskName = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      // Date selected
      selectedDate = picked;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      // Time selected
      selectedTime = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Text('Add your tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
            SizedBox(height: 100,),
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
              child: InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Time',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedTime.format(context)),
                      Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                addTaskController.addTask(
                  taskName.text,
                  subTaskName.text,
                  DateFormat('dd/MM/yyyy').format(selectedDate),
                  selectedTime.format(context),
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
