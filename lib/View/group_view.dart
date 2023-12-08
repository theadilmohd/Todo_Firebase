// views/group_view.dart
import 'package:flutter/material.dart';
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
          Center(child: Text(groupModel.groupName)),
        ],
      ),
    );
  }
}
