import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo_app/Custome_Functions/Custome_Strings/heading.dart';
import 'Controller/TaskController.dart';
import 'Custome_Functions/System_Orientation_and_SystemUIOverlayStyle/System_Orientation_and_SystemUIOverlayStyle_all_screen.dart';
import 'Custome_Functions/Themes/Theme.dart';
import 'View/Dashborad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  System_Orientation_and_SystemUIOverlayStyle_all_screen();
  final taskController =
      Get.put(TaskController()); // Create TaskController instance
  final theme = await AppTheme.getThemeFromPreferences();
  runApp(MyApp(initialTheme: theme, taskController: taskController));
}

class MyApp extends StatelessWidget {
  final ThemeData initialTheme;
  final TaskController taskController;

  const MyApp(
      {Key? key, required this.initialTheme, required this.taskController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: CustomHeading.application_name,
      theme: initialTheme,
      home: MyHomePage(taskController: taskController),
    );
  }
}
