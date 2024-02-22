import 'package:hive/hive.dart';

part 'todo_adapter.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool status;
  @HiveField(3)
  DateTime dateTime;

  Todo(
      {required this.title,
      required this.description,
      this.status = false,
      required this.dateTime});
}
