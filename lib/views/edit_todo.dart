import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_pad/adapters/todo_adapter.dart';
import 'package:note_pad/style.dart';

class EditTodo extends StatefulWidget {
  final String title;
  final String dec;
  final int index;

  const EditTodo(
      {Key? key, required this.title, required this.dec, required this.index})
      : super(key: key);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  @override
  void initState() {
    super.initState();
    title = widget.title;
    description = widget.dec;
  }

  final formKey = GlobalKey<FormState>();

  String title = '', description = '';

  submitData() async {
    if (formKey.currentState!.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todoBox');
      todoBox.putAt(
          widget.index,
          Todo(
              title: title,
              description: description,
              dateTime: DateTime.now()));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
        ),
        child: Column(
          children: [
            IntrinsicWidth(
              stepWidth: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (title.isNotEmpty && description.isNotEmpty) {
                          Box<Todo> todoBox = Hive.box<Todo>('todoBox');
                          todoBox.putAt(
                              widget.index,
                              Todo(
                                title: title,
                                description: description,
                                dateTime: DateTime.now(),
                              ));
                        } else if (title == '' && description == '') {
                          Get.back();
                        }
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () => submitData(),
                      icon: const Icon(
                        Icons.save_alt,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: title,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                              hintText: 'Add title',
                              hintStyle: TextStyle(
                                  color: Colors.white70, fontSize: 25),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                          validator: (text) {
                            if (text!.isEmpty) {}
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          initialValue: description,
                          maxLines: null,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                              hintText: 'Add description',
                              hintStyle: TextStyle(
                                  color: Colors.white70, fontSize: 25),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
