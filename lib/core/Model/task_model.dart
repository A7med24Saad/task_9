import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String note;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String start_time;

  @HiveField(4)
  final String end_time;

  @HiveField(5)
  final int color;

  @HiveField(6)
  final bool iscomplete;

  Task(
      {required this.title,
      required this.note,
      required this.date,
      required this.start_time,
      required this.end_time,
      required this.color,
      required this.iscomplete});

  get endTime => null;
}
