// views/group_view.dart
import 'package:flutter/material.dart';
import 'package:mytodo/View/users_page.dart';
import 'package:mytodo/model/user_model.dart';
//import 'package:mytodo/models/group_model.dart';

class GroupView extends StatelessWidget {
  final GroupModel groupModel = GroupModel(groupName: 'Group is coming soon');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       //   SizedBox(height: 30,),
          //                     GestureDetector(
          //   onTap: () {
          //          Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => UsersPage()),
          //   );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       height:70,
          //       width: 400,
          //              //   decoration: BoxDecoration(  borderRadius: BorderRadius.all(Radius.circular(20))),
          //      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
          //       color:Color.fromARGB(255, 45, 3, 51).withOpacity(0.5),
                
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Icon(Icons.supervised_user_circle,size:25),
                
          //             Text('Users',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
          //             Icon(Icons.arrow_forward_ios,size: 25,)
          //           ],
          //         ),
          //       ),
                
                      
          //     ),
          //   ),
          // ),
          Center(child: Text(groupModel.groupName)),
        ],
      ),
    );
  }
}
