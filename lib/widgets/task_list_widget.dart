// widget for show have task or no
import 'package:flutter/material.dart';
import 'package:productivity_app/model/task_model.dart';
import 'package:productivity_app/views/task_detail_screen.dart';
import 'package:productivity_app/widgets/task_container.dart';

Widget taskList(List<Task> tasks, double height) {
  return Container(
    padding: EdgeInsets.only(bottom: height * 0.1),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: height * 0.09),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: tasks.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 25); // Adjust the spacing as needed
        },
        itemBuilder: (BuildContext context, int index) {
          final task = tasks[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TaskDetailScreen(task: task);
              }));
            },
            child: CustomContainer(
              text: task.taskName,
              time: task.dueTime,
              date: task.dueDate,
            ),
          );
        },
      ),
    ),
  );
}