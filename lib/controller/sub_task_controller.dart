// ignore_for_file: prefer_const_constructors, unused_local_variable, camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';

import '../model/task_database.dart';
import '../model/sub_task_model.dart';

class SubtaskController {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController subtaskTitleController;
  final int mainTaskId;

  SubtaskController({
    required this.scaffoldKey,
    required this.subtaskTitleController,
    required this.mainTaskId,
  });

  Future<void> addSubtask(BuildContext context) async {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }
    SubTask newSubtask = SubTask(
      judul: subtaskTitleController.text,
      idMainTask: mainTaskId,
      isCompleted: 0,
    );

    try {
      insertSubTask(newSubtask);
      final currentContext = scaffoldKey.currentContext;
      if (currentContext != null) {
        ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(
          content: Text("Subtask Added Successfully!"),
          duration: Duration(seconds: 2),
        ));
      }

      // Add logic to handle after adding subtask
    } catch (e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text("Add Subtask Failed"),
        duration: Duration(seconds: 2),
      ));
    }
  }
}

class subTaskListController {
  final StreamController<List<SubTask>> _subtaskStreamController =
      StreamController<List<SubTask>>.broadcast();

  Stream<List<SubTask>> get subtaskStream => _subtaskStreamController.stream;

  Future<void> fetchSubtasks(int mainTaskId) async {
    try {
      final List<SubTask> subtasks = await readSubTasksByMainTask(mainTaskId);
      _subtaskStreamController.add(subtasks);
    } catch (e) {
      // Handle potential database errors gracefully (e.g., logging, error message)
    }
  }

  void dispose() {
    _subtaskStreamController.close();
  }
}

class UpdateSubTaskController {
  void toggleCompletedSubTask(SubTask subtask, bool ischecked) async {
    subtask.isCompleted = ischecked ? 1 : 0;
    updateSubTask(subtask);
  }
}
