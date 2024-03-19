import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_todo_app/Controller/TaskController.dart';
import 'package:task_todo_app/Models/TaskModel.dart';

void main() {
  test('Delete data to shared_prefrences', () {
    final taskController = Get.put(TaskController());
    taskController.addTask('title', 'category', DateTime.now());
    taskController.deleteTask(taskController.allTasks.first);
  });
}
