import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_pad/adapters/todo_adapter.dart';
import 'package:note_pad/style.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'add_todo.dart';

class ViewTodoList extends StatefulWidget {
  const ViewTodoList({Key? key}) : super(key: key);

  @override
  State<ViewTodoList> createState() => _ViewTodoListState();
}

class _ViewTodoListState extends State<ViewTodoList> {
  late Box<Todo> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>('todoBox');
    todoBox.listenable().addListener(_updateIndicator);
  }

  @override
  void dispose() {
    todoBox.listenable().removeListener(_updateIndicator);
    super.dispose();
  }

  void _updateIndicator() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(
            const AddTodo(),
            transition: Transition.downToUp,
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
      appBar: AppBar(
        leading: const Icon(
          Icons.task,
          color: Colors.white,
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'All Task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Todo>('todoBox').listenable(),
          builder: (context, Box<Todo> box, _) {
            if (box.values.isEmpty) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 80.0, color: Colors.white70),
                  Center(
                    child: Text(
                      'No task available',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            }
            int totalTasks = box.length;
            int tasksDone = box.values.where((todo) => todo.status).length;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Total Tasks: $totalTasks',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(
                      width: Get.size.width * 0.6,
                      child: StepProgressIndicator(
                          totalSteps: totalTasks,
                          currentStep: tasksDone,
                          padding: 0,
                          size: 5,
                          selectedGradientColor: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue, Colors.blue[400]!]),
                          unselectedGradientColor: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.white54, Colors.white54])),
                    ),
                    Text(
                      'Tasks Done: $tasksDone',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        Todo? todoContent = box.getAt(index);
                        return GestureDetector(
                          onTap: () => Get.bottomSheet(ViewTask(
                            title: todoContent.title,
                            task: todoContent.description,
                            date: '',
                            status: todoContent.status,
                          )),
                          child: Card(
                            color: kPrimaryColor.withOpacity(0.5),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              leading: Checkbox(
                                onChanged: (bool? value) {
                                  todoContent.status = value!;
                                  box.putAt(index, todoContent);
                                },
                                value: todoContent!.status,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Get.bottomSheet(Container(
                                    height: 200,
                                    color: kPrimaryColor.withOpacity(0.5),
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            width: 150,
                                            child: Image.asset(
                                                'assets/delete.gif')),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  await box.deleteAt(index);
                                                  Get.back();
                                                },
                                                child: const Text('Yes')),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('No')),
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white70,
                                ),
                              ),
                              title: Text(
                                todoContent.title,
                                style: TextStyle(
                                    decoration: todoContent.status
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: todoContent.status
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                todoContent.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ViewTask extends StatelessWidget {
  String title;
  String task;
  bool status;
  String date;
  ViewTask(
      {super.key,
      required this.title,
      required this.task,
      required this.date,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
