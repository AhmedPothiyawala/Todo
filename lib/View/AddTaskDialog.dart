import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_todo_app/Custome_Functions/Colors/constants.dart';

class AddTaskDialog extends StatelessWidget {
  final void Function(String title, String category, DateTime? dueDate)
      onAddTask;
  List<String> categories = [];

  AddTaskDialog({Key? key, required this.onAddTask, required this.categories})
      : super(key: key);

  final TextEditingController _textController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _selectedCategory = TextEditingController();

  // Initial category
  @override
  void dispose() {
    _textController.dispose();
    _dueDateController.dispose();
    _selectedCategory.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _selectedDueDate = Rx<DateTime?>(null);
    return AlertDialog(
      contentPadding: EdgeInsets.all(15),
      actionsAlignment: MainAxisAlignment.center,
      content: Container(
          height: 300,
          child: SingleChildScrollView(
              child: Column(children: [
            Text('Add Task'),
            Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    controller: _textController,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (_textController.text == '' ||
                          _textController.text.isEmpty == true) {
                        return 'Enter Title';
                      } else if (value!.length >= 1) {
                        return null;
                      } else {
                        return 'Enter Title';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, top: 10),
                  child: DropdownButton<String>(
                      value: 'Work',
                      isExpanded: true,
                      items: categories.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        _selectedCategory.text =
                            value!; // Update selected value
                      }),
                ),
                TextFormField(
                  validator: (value) {
                    if (_dueDateController.text == '' ||
                        _dueDateController.text.isEmpty == true) {
                      return 'Select date';
                    } else if (value!.length >= 1) {
                      return null;
                    } else {
                      return 'Select Date';
                    }
                  },
                  controller: _dueDateController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Due Date'),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    _selectedDueDate.value = selectedDate;
                    _dueDateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDate!);
                  },
                ),
              ]),
            ),
          ]))),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                Theme.of(context).brightness == Brightness.light
                    ? TodoColors.kPrimaryDarkColor
                    : TodoColors.kPrimaryLightColor,
              )),
              onPressed: () {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                if (_formKey.currentState!.validate()) {
                  final title = _textController.text.trim();
                  if (title.isNotEmpty) {
                    onAddTask(title, _selectedCategory.text,
                        DateTime.parse(_dueDateController.text));
                    Get.back();
                    Get.snackbar('Successfully', 'Record Added',
                        backgroundColor: Colors.green,
                        icon: Icon(
                          Icons.check_circle_rounded,
                          size: 30,
                        ),
                        snackPosition: SnackPosition.TOP);
                  }
                }
              },
              child: Text('Save Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.light
                        ? TodoColors.kPrimaryLightColor
                        : TodoColors.kPrimaryDarkColor,
                  ))),
        )
      ],
    );
  }
}
