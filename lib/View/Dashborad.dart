import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo_app/Controller/Storage.dart';
import '../Controller/ExitController.dart';
import '../Controller/TaskController.dart';
import '../Custome_Functions/Colors/constants.dart';
import '../Custome_Functions/Custome_Strings/heading.dart';
import '../Custome_Functions/Themes/Theme.dart';
import 'AddTaskDialog.dart';
import 'TaskList.dart';

class MyHomePage extends StatefulWidget {
  final TaskController taskController;
  const MyHomePage({Key? key, required this.taskController}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDarkMode = false; // Initial state for dark mode toggle
  final exitConfirmationController = Get.put(ExitConfirmationController());
  @override
  void initState() {
    super.initState();
    _getDarkModePreference();
  }

  Future<void> _getDarkModePreference() async {
    _isDarkMode = await Storage.getDarkModePreference();
  }

  void _toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await Storage.setDarkModePreference(_isDarkMode);
    final theme = await AppTheme.getThemeFromPreferences();
    Get.changeTheme(theme);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exitConfirmationController.showExitConfirmation(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? TodoColors.kPrimaryLightColor
                : TodoColors.kPrimaryDarkColor,
            title: Text(CustomHeading.application_name,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? TodoColors.kPrimaryDarkColor
                      : TodoColors.kPrimaryLightColor,
                )),
            actions: [
              IconButton(
                icon: Icon(
                  _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Theme.of(context).brightness == Brightness.light
                      ? TodoColors.kPrimaryDarkColor
                      : TodoColors
                          .kPrimaryLightColor, // Adjust colors as needed,
                ),
                onPressed: _toggleDarkMode,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? TodoColors.kPrimaryDarkColor
                : TodoColors.kPrimaryLightColor,
            isExtended: true,
            child: Icon(
              Icons.add,
              color: Theme.of(context).brightness == Brightness.light
                  ? TodoColors.kPrimaryLightColor
                  : TodoColors.kPrimaryDarkColor,
            ),
            onPressed: () {
              Get.dialog(AddTaskDialog(
                onAddTask: widget.taskController.addTask,
                categories: widget.taskController.categories,
              ));
            },
          ),
          body: Builder(
              // Wrap Scaffold with Builder
              builder: (context) => TaskList(
                    taskController: widget.taskController,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black26, // Adjust colors as needed
                    textColor: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                  ))),
    );
  }
}
