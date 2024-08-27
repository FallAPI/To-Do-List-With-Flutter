// ignore_for_file: unused_element, avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, override_on_non_overriding_member
import 'package:productivity_app/widgets/color_widget.dart';
import 'package:productivity_app/views/add_task_screen.dart';
import 'package:productivity_app/controller/task_contoller.dart';
import 'package:productivity_app/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/no_task_widget.dart';
import 'package:productivity_app/widgets/task_list_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TaskListController _taskListController = TaskListController();

  @override
  void initState() {
    super.initState();
    _taskListController.fetchTasks();
  }

  @override
  void dispose() {
    _taskListController.dispose();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(
                taskListController: _taskListController,
              ),
            ),
          );
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        child: Icon(
          Icons.add,
          color: AppColor.white,
          size: 32,
        ),
      ),
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Refresh the UI by calling setState
            setState(() {
              _taskListController.fetchTasks();
            });
          },
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding * 0.05,
                      horizontal: horizontalPadding * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style: TextStyle(
                            color: AppColor.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.055,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          "Are you ready to be productive?",
                          style: TextStyle(
                            color: AppColor.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.052,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "My Task",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: AppColor.white,
                            letterSpacing: 0.03,
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.04,
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        StreamBuilder<List<Task>>(
                          stream: _taskListController.taskStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
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
                              final tasks = snapshot.data ?? [];
                              return tasks.isEmpty
                                  ? noTaskFound(width, height)
                                  : taskList(tasks, horizontalPadding);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



