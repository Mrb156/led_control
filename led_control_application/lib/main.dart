import 'package:flutter/material.dart';
import 'package:led_control_application/together.dart';
import 'package:led_control_application/unitMainTable.dart';
import 'package:led_control_application/unitSecTable.dart';
import 'package:led_control_application/unitWall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;
  final pages = const <Widget>[
    MainControl(),
    unitWall(),
    unitMainTable(),
    unitSecTable()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.teal,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Fő'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Fal'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb), label: 'Nagy asztal'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb), label: 'Kis asztal'),
        ],
      ),
      body: pages.elementAt(_selectedIndex),
    );
  }
}
