import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_pad/views/edit_todo.dart';
import 'package:timeago/timeago.dart' as timeago;
class ViewTask extends StatelessWidget {
  String title;
  String task;
  bool status;
  DateTime date;
  int index;
  ViewTask(
      {super.key,
      required this.title,
      required this.task,
      required this.date,
      required this.index,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicWidth(
              stepWidth: double.infinity,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: double.infinity,
                color: Colors.grey[800],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                          Get.to(
                              EditTodo(title: title, dec: task, index: index));
                        },
                        icon: const Icon(Icons.edit, color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.size.height * 1 / 900),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    task,
                    style: const TextStyle(fontSize: 16, color: Colors.white60),
                  ),
                ],
              ),
            ),
          ],
        ),
        IntrinsicWidth(
          stepWidth: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: double.infinity,
            color: Colors.grey[800],
            child: Text(
              timeago.format(date),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
