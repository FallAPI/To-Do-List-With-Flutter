// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable, unused_field

import 'package:flutter/material.dart';
import 'package:productivity_app/widgets/color_widget.dart';
import 'package:productivity_app/widgets/button_widget.dart';
import 'package:productivity_app/controller/task_contoller.dart';
import 'package:productivity_app/model/task_model.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  final TaskListController taskListController;
  const AddTask({super.key, required this.taskListController});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDueDateController = TextEditingController();
  final TextEditingController _taskDueTimeController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final FocusNode _taskFocusNode = FocusNode();
  late final Task task;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  late TaskController _addTaskController;

  @override
  void initState() {
    super.initState();
    _addTaskController = TaskController(
      scaffoldKey: GlobalKey<ScaffoldState>(),
      taskNameController: _taskNameController,
      taskDueDateController: _taskDueDateController,
      taskDueTimeController: _taskDueTimeController,
      taskDescriptionController: _taskDescriptionController,
      taskListController: widget.taskListController,
    );
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _taskDueDateController.text =
            DateFormat("dd-MM-yyyy").format(pickedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        int hour = _selectedTime!.hour;

        String amPmIndicator = hour < 12 ? "AM" : "PM";

        _taskDueTimeController.text = '${_selectedTime!.hourOfPeriod}:'
            '${_selectedTime!.minute} $amPmIndicator';
      });
    }
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
      key: _addTaskController.scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding * 0.03,
                  horizontal: horizontalPadding * 0.05,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  color: Colors.white,
                  iconSize: height * 0.035,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.045,
                      letterSpacing: 0.03,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPadding * 0.05),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding * 0.02),
                              child: Text(
                                "New Task",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.027,
                                    letterSpacing: 0.03),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextFormField(
                              controller: _taskNameController,
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "Poppins"),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.white),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                filled: true,
                                fillColor: _taskFocusNode.hasFocus
                                    ? AppColor.white
                                    : AppColor.white,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter  task name";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      TextFormField(
                        controller: _taskDueDateController,
                        decoration: InputDecoration(
                          labelText: 'Due Date',
                          labelStyle: TextStyle(
                            color: AppColor.white,
                            fontSize: height * 0.029,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.white), // Change border color
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.white), // Change border color
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        style: TextStyle(
                          color: AppColor.white,
                          fontFamily: "Poppins",
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (_selectedDate == null || value!.isEmpty) {
                            return 'Please select a due date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      TextFormField(
                        controller: _taskDueTimeController,
                        decoration: InputDecoration(
                          labelText: 'Due Time',
                          labelStyle: TextStyle(
                            color: AppColor.white,
                            fontSize: height * 0.029,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.timer_outlined),
                            onPressed: () => _selectTime(context),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.white), // Change border color
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.white), // Change border color
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        style: TextStyle(
                          color: AppColor.white,
                          fontFamily: "Poppins",
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (_selectedDate == null || value!.isEmpty) {
                            return 'Please select a due date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding * 0.02),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: height * 0.027,
                                    letterSpacing: 0.03),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextFormField(
                              maxLines: 4,
                              controller: _taskDescriptionController,
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "Poppins"),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.white),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  filled: true,
                                  fillColor: _taskFocusNode.hasFocus
                                      ? AppColor.white
                                      : AppColor.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Center(
                child: CustomButton(
                  text: "Add New Task",
                  onPress: () {
                    if (_form.currentState!.validate()) {
                      _addTaskController.addTask(context);
                      _taskNameController.clear();
                      _taskDueDateController.clear();
                      _taskDueTimeController.clear();
                      _taskDescriptionController.clear();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
