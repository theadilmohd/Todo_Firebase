import 'package:flutter/material.dart';
import 'package:mytodo/View/group_view.dart';
import 'package:mytodo/View/settings_page.dart';
import 'package:mytodo/View/todo_view.dart';
import 'package:mytodo/controller/Home_controller.dart';
import 'package:mytodo/model/user_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = HomeController();
  //int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final UserModel currentUser = homeController.getCurrentUser();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 20,
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: Image.network(currentUser.photoURL).image,
                ),
              ),
              const Text(
                "My Todo",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, ${currentUser.displayName}!',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Builder(
            builder: (BuildContext context) =>
                Expanded(child: pages[_selectIndex]),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded),
            label: "Group",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}

final List<Widget> pages = <Widget>[
  GroupView(),
  TodoView(),
 // Settings(),
 const SettingsPage(),
];
