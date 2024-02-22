import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_pad/adapters/todo_adapter.dart';
import 'package:note_pad/style.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final formKey = GlobalKey<FormState>();

  String title = '', description = '';

  submitData() async {
    if (formKey.currentState!.validate()) {
      Box<Todo> todoBox = Hive.box<Todo>('todoBox');
      todoBox.add(Todo(title: title, description: description,  dateTime: DateTime.now(),));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: IconButton(
                        onPressed: () {
                          if (title.isNotEmpty && description.isNotEmpty) {
                            Box<Todo> todoBox = Hive.box<Todo>('todoBox');
                            todoBox.add(Todo(
                              title: title,
                              description: description, dateTime: DateTime.now(),
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
                  ),
                  title == '' && description == ''
                      ? Container()
                      : IconButton(
                          onPressed: () => submitData(),
                          icon: const Icon(
                            Icons.save_alt,
                            color: Colors.white,
                          ))
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
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
                            if (text!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('empty fields')));
                              return '';
                            }
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
                          cursorColor: Colors.white,
                          maxLines: null,
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
                          validator: (text) {
                            if (text!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('empty fields')));
                              return '';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
