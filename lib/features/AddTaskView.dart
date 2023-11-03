import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_9/cash.dart';
import 'package:task_9/core/color.dart';
import 'package:task_9/core/styles.dart';
import 'package:task_9/features/Home_View.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  
  static int NumOfTasks = 0;
  var titleCon = TextEditingController();
  var noteCon = TextEditingController();
 
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Title",
            style: getSubTitleStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: titleCon,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Title mustn\'t be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter a Title here',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Note',
            style: getSubTitleStyle(),
          ),
          TextFormField(
            controller: noteCon,
            maxLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Note mustn\'t be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Enter a Note here',
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Date',
            style: getSubTitleStyle(),
          ),
          TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () async {
                    final datePicked = await showDatePicker(
                      currentDate: DateTime.now(),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2050),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.primaryColor,
                              onPrimary: Colors.white,
                              onSurface: AppColors.primaryColor,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (datePicked != null) {
                      setState(() {
                        _date = datePicked;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: AppColors.primaryColor,
                  )),
              hintText: DateFormat.yMd().format(_date),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Start Time',
                style: getSubTitleStyle(),
              )),
              Expanded(
                  child: Text(
                'End Time',
                style: getSubTitleStyle(),
              )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final datePicked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColors
                                        .primaryColor, // header background color
                                    onPrimary:
                                        Colors.black, // header text color
                                    onSurface: AppColors
                                        .primaryColor, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors
                                          .primaryColor, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (datePicked != null) {
                            setState(() {
                              _startTime = datePicked.format(context);
                              int plus15Min = datePicked.minute + 15;
                              _endTime = datePicked
                                  .replacing(minute: plus15Min)
                                  .format(context);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.watch_later_outlined,
                          color: AppColors.primaryColor,
                        )),
                    hintText: _startTime,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final timePicker = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(DateTime.now()
                                .add(const Duration(minutes: 15))),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData(
                                  colorScheme: ColorScheme.light(
                                    primary: AppColors
                                        .primaryColor, // header background color
                                    onPrimary:
                                        Colors.black, // header text color
                                    onSurface: AppColors
                                        .primaryColor, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors
                                          .primaryColor, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (timePicker != null) {
                            setState(() {
                              _endTime = timePicker.format(context);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.watch_later_outlined,
                          color: AppColors.primaryColor,
                        )),
                    hintText: _endTime,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // ---------- Choose a Color ----------------
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = 0;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 20,
                      child: (_selectedColor == 0)
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = 1;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.orangeColor,
                      radius: 20,
                      child: (_selectedColor == 1)
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = 2;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.redColor,
                      radius: 20,
                      child: (_selectedColor == 2)
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  )
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ));
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    NumOfTasks++;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor,
                    ),
                    child: const Text(
                      'Create Task',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
