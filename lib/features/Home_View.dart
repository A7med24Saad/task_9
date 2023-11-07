import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:task_9/core/Model/task_model.dart';
import 'package:task_9/core/color.dart';
import 'package:task_9/core/styles.dart';
import 'package:task_9/features/AddTaskView.dart';
import 'package:task_9/features/widgets/Task_item.dart';
import 'package:task_9/features/widgets/header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime selectedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.MMMMEEEEd().format(DateTime.now()),
                          style: getTitleStyle()),
                      Text(
                        'Today',
                        style: getTitleStyle(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddTaskView(),
                      ));
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColor),
                      child: Text(
                        '+ add Task',
                        style: getSmallTextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DatePicker(DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: selectedTime,
                  selectionColor: AppColors.primaryColor,
                  selectedTextColor: const Color.fromRGBO(255, 255, 255, 1),
                  onDateChange: (date) {
                setState(() {
                  selectedTime = date;
                });
              }),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: Hive.box<Task>('task').listenable(),
                builder:
                    (BuildContext context, Box<Task> value, Widget? child) {
                  List<Task> tasks = value.values.where((element) {
                    if (element.date.split('T').first ==
                        selectedTime.toIso8601String().split('T').first) {
                      return true;
                    } else {
                      return false;
                    }
                  }).toList();
                  if (tasks.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Image.asset('assets/empty.png'),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          Task item = tasks[index];
                          return Dismissible(
                              background: Container(
                                color: AppColors.redColor,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.delete_forever_rounded),
                                    Text(
                                      'Delete',
                                    )
                                  ],
                                ),
                              ),
                              secondaryBackground: Container(
                                color: Colors.green,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.check),
                                    Text('Complete')
                                  ],
                                ),
                              ),
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  setState(() {
                                    value.delete(
                                      '${item.title} ${item.date}',
                                    );
                                  });
                                } else {
                                  setState(() {
                                    value.put(
                                        '${item.title} ${item.date}',
                                        Task(
                                            Id: '${item.title} ${item.date}',
                                            title: item.title,
                                            note: item.note,
                                            date: item.date,
                                            start_time: item.start_time,
                                            end_time: item.end_time,
                                            color: 3,
                                            iscomplete: true));
                                  });
                                }
                              },
                              child: TaskItem(task: item));
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
