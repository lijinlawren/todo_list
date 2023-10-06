import 'package:flutter/material.dart';
import 'package:todo_list/change_password.dart';
import 'package:todo_list/completed_task.dart';
import 'package:todo_list/slashscreen.dart';

import 'login.dart';
import 'home.dart';
import 'list_data.dart';
import 'all_task.dart';
import 'edit_task.dart';
import 'todo_account.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo-WishList',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: SlashScreen(),
    );
  }
}
