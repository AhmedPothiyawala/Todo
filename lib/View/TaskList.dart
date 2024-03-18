import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controller/TaskController.dart';
import '../Custome_Functions/Colors/constants.dart';

class TaskList extends StatelessWidget {
  final TaskController taskController;
  final Color? backgroundColor;
  final Color? textColor;

  const TaskList(
      {Key? key,
      required this.taskController,
      this.backgroundColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => taskController.allTasks.length <= 0
          ? Center(
              child: Text(
                'No Record Found',
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? TodoColors.kPrimaryDarkColor
                        : TodoColors.kPrimaryLightColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: taskController.allTasks.length,
              itemBuilder: (context, index) {
                final task = taskController.allTasks[index];
                final today = DateTime.now();
                final isOverdue =
                    task.dueDate != null && task.dueDate!.isBefore(today);
                final isUpcoming = task.dueDate != null &&
                    task.dueDate!.isAfter(today
                        .subtract(const Duration(days: 1))); // Within next day
                return Dismissible(
                    key: ValueKey(task.id),
                    background: Container(color: Colors.red),
                    onDismissed: (_) => taskController.deleteTask(task),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? TodoColors.kPrimaryDarkColor
                                  : TodoColors.kPrimaryLightColor,
                        ),
                      ),
                      elevation: 16,
                      shadowColor: Colors.red,
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? TodoColors.kPrimaryDarkColor
                                  : TodoColors.kPrimaryLightColor,
                        ),
                        title: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(
                            StringUtils.capitalize(task.title, allWords: true),
                            style: isOverdue
                                ? TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? TodoColors.kPrimaryDarkColor
                                        : TodoColors.kPrimaryLightColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10)
                                : null,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(StringUtils.capitalize(task.category,
                                allWords: true)),
                            if (task.dueDate != null)
                              Text(
                                  ' - Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate!)}'),
                            if (isUpcoming)
                              const Text(
                                ' (Upcoming)',
                                style: TextStyle(color: Colors.orange),
                              ),
                          ],
                        ),
                        trailing: Checkbox(
                          fillColor: MaterialStateProperty.all(
                              Theme.of(context).brightness == Brightness.light
                                  ? TodoColors.kPrimaryLightColor
                                  : TodoColors.kPrimaryDarkColor),
                          checkColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? TodoColors.kPrimaryDarkColor
                                  : TodoColors.kPrimaryLightColor,
                          value: task.completed,
                          onChanged: (value) =>
                              taskController.toggleCompleted(task),
                        ),
                      ),
                    ));
              },
            ),
    );
  }
}
