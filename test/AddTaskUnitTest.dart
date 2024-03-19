import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_todo_app/Controller/TaskController.dart';


void main() {
  test('Add data to shared_prefrences', () {
    final taskController = Get.put(TaskController());
    taskController.addTask('title', 'category', DateTime.now());
  });
}
