// ignore_for_file: avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:productivity_app/model/task_model.dart';

import 'package:productivity_app/widgets/color_widget.dart';
import 'package:productivity_app/widgets/button_widget.dart';

import '../controller/sub_task_controller.dart';
import '../controller/task_contoller.dart';
import '../model/sub_task_model.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final SubTask? subtask;
  const TaskDetailScreen({super.key, required this.task, this.subtask});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController subtaskTitleController = TextEditingController();
  final subTaskListController _subtaskController = subTaskListController();
  late SubtaskController subtaskController;
  final UpdateTaskController update = UpdateTaskController();
  final UpdateSubTaskController UpdateSubTask = UpdateSubTaskController();

  @override
  void initState() {
    super.initState();
    _subtaskController.fetchSubtasks(widget.task.id!);
  }

  @override
  void dispose() {
    _subtaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final Size screenSize = MediaQuery.of(context).size;
    final double horizontalPadding = screenSize.width;
    final double verticalPadding = screenSize.height;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: verticalPadding * 0.03,
                        horizontal: horizontalPadding * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_rounded),
                            color: Colors.white,
                            iconSize: height * 0.035,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            iconSize: height * 0.035,
                            onPressed: () {
                              DeleteTaskController deleteTaskController =
                                  DeleteTaskController(
                                scaffoldKey: GlobalKey<ScaffoldMessengerState>(),
                                context: context,
                              );
                              // Call deleteTaskById function
                              deleteTaskController.deleteTaskById(widget.task);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          "Detail Task",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.05,
                            letterSpacing: 0.003,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: verticalPadding * 0.04,
                        horizontal: horizontalPadding * 0.05,
                      ),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: widget.task.isCompleted == 1,
                        onChanged: (bool? value) {
                          setState(() {
                            update.toggleCompletedTask(widget.task, value!);
                          });
                        },
                        title: Text(
                          widget.task.taskName,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.03,
                            letterSpacing: 0.003,
                          ),
                        ),
                        subtitle: Text(
                          widget.task.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: height * 0.02,
                          ),
                        ),
                        isThreeLine: true,
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Due Time",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: height * 0.022,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: AppColor.white,
                                      size: height * 0.025,
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(
                                      widget.task.dueTime,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: height * 0.021,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Due Date",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: height * 0.023,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: AppColor.white,
                                      size: height * 0.025,
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Text(
                                      widget.task.dueDate,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: height * 0.021,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.09,
                    ),
                     const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
          
                    // tampilkan subtask berdasarkan id main task
                    StreamBuilder<List<SubTask>>(
                      stream: _subtaskController.subtaskStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return  const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "An error occurred!",
                              style: TextStyle(
                                color: AppColor.white,
                                fontFamily: "Poppins",
                                fontSize: height * 0.037,
                                letterSpacing: 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        } else {
                          final subtasks = snapshot.data ?? [];
                          return subtasks.isEmpty
                              ? const Text("You don't have sub tasks",
                                  style: TextStyle(color: Colors.white))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: subtasks.length,
                                  itemBuilder: (context, index) {
                                    final subtask = subtasks[index];
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: subtask.isCompleted == 1,
                                      onChanged: (bool? value) {
                                        setState(() {});
                                        UpdateSubTask.toggleCompletedSubTask(
                                            subtask, value!);
                                      },
                                      title: Text(
                                        subtask.judul,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: height * 0.02,
                                        ),
                                      ),
                                    );
                                  },
                                );
                        }
                      },
                    ),
                    const SizedBox(height: 100), // Add some space to ensure the last item is not covered by the button
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  text: "Add Sub Task",
                  onPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Judul Form"),
                          content: Form(
                            key: _form,
                            child: TextFormField(
                              controller: subtaskTitleController,
                              decoration: const InputDecoration(
                                labelText: "Sub Task",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Sub task tidak boleh kosong ";
                                }
                                return null;
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Simpan"),
                              onPressed: () {
                                subtaskController = SubtaskController(
                                    scaffoldKey: GlobalKey<ScaffoldState>(),
                                    subtaskTitleController:
                                        subtaskTitleController,
                                    mainTaskId: widget.task.id!);
                                if (_form.currentState!.validate()) {
                                  subtaskController.addSubtask(context);
                                  _subtaskController
                                      .fetchSubtasks(widget.task.id!);
                                  Navigator.of(context).pop();
                                  subtaskTitleController.clear();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
