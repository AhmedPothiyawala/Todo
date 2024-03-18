import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_todo_app/Controller/Storage.dart';
import '../Models/TaskModel.dart';

class TaskController extends GetxController {
  final _tasks = RxList<Task>([]);
  final _selectedCategory = RxString(''); // Category filter
  List<Task> get allTasks => _tasks.toList();
  final List<String> categories = [
    'Work',
    'Personal',
    'Shopping',
    'Other'
  ]; // Optional predefined categories

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _tasks.value = await Storage.loadTasks();
  }

  void addTask(String title, String category, DateTime? dueDate) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      category: category,
      dueDate: dueDate,
    );
    _tasks.add(newTask);
    Storage.saveTasks(_tasks.toList());
    update();
  }

  void toggleCompleted(Task task) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      final updatedTask = task.copyWith(completed: !task.completed);
      _tasks[index] = updatedTask;
      Storage.saveTasks(_tasks.toList());
      update();
    }
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    Storage.saveTasks(_tasks.toList());
    update();
    Get.snackbar('Deleted', task.title,
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.delete,
          size: 30,
        ),
        snackPosition: SnackPosition.TOP);
  }

  void updateCategory(String category) {
    _selectedCategory.value = category;
    update();
  }

  List<Task> get filteredTasks => _tasks
      .where((task) =>
          task.category.isEmpty || task.category == _selectedCategory.value)
      .toList();
}
