// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productivity_app/model/task_model.dart';
import 'package:productivity_app/model/task_database.dart';

class TaskController {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController taskNameController;
  final TextEditingController taskDueDateController;
  final TextEditingController taskDueTimeController;
  final TextEditingController taskDescriptionController;

  final TaskListController taskListController; // Added TaskListController

  TaskController({
    required this.scaffoldKey,
    required this.taskNameController,
    required this.taskDueDateController,
    required this.taskDueTimeController,
    required this.taskDescriptionController,
    required this.taskListController, // Pass TaskListController
  });

  Future<void> addTask(BuildContext context) async {
    if (_form.currentState != null && !_form.currentState!.validate()) {
      return;
    }
    Task newTask = Task(
      taskName: taskNameController.text,
      dueDate: taskDueDateController.text,
      dueTime: taskDueTimeController.text,
      description: taskDescriptionController.text,
      isCompleted: 0,
    );

    try {
      await insertTask(newTask);
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text("Task Added Successfully!"),
        duration: Duration(seconds: 2),
      ));
      taskListController.fetchTasks(); // Trigger data refresh after adding task
    } catch (e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text("Add Task Failed"),
        duration: Duration(seconds: 2),
      ));
    }
  }
}

class TaskListController {
  final StreamController<List<Task>> _taskStreamController =
      StreamController<List<Task>>.broadcast();

  Stream<List<Task>> get taskStream => _taskStreamController.stream;

  Future<void> fetchTasks() async {
    try {
      final List<Task> tasks = await readAllTasks();
      _taskStreamController.add(tasks);
    } catch (e) {

      // Handle errors if necessary
    }
  }

  void dispose() {
    _taskStreamController.close();
  }
}

class DeleteTaskController {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  final BuildContext context;

  DeleteTaskController({required this.scaffoldKey, required this.context});

  Future<void> deleteTaskById(Task task) async {
    try {
      // You can directly access the ID of the task from the task object
      int id = task.id!;
      await deleteTask(id);

      // Delay navigation by 3 seconds
      await Future.delayed(Duration(seconds: 3));

      // Navigate back to previous screen
      Navigator.pop(context);
    } catch (e) {
      // Handle errors if necessary
    }
  }
}

class UpdateTaskController{
  void toggleCompletedTask(Task task, bool isChecked) async{
    task.isCompleted = isChecked ? 1 : 0 ;
    await updateTask(task);
  }
}
