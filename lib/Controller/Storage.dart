import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/TaskModel.dart';

class Storage {
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = prefs.getStringList('tasks');
    if (encodedTasks == null) {
      return [];
    }
    return encodedTasks.map((task) => Task.fromJson(jsonDecode(task))).toList();
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', encodedTasks);
  }

  static Future<bool> getDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkMode') ?? false; // Default to light mode
  }

  static Future<void> setDarkModePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
    Get.isDarkMode;
  }
}
