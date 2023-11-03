import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_9/core/color.dart';
import 'package:task_9/core/styles.dart';
import 'package:task_9/features/AddTaskView.dart';
import 'package:task_9/features/widgets/header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {}),
            const SizedBox(height: 10),
           
          ],
        ),
      ),
    ));
  }
}
