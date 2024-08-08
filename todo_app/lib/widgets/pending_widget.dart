import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/services/database_services.dart';
import 'package:todo_app/widgets/showTaskDialogue.dart';

import '../model/todo_model.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({super.key});

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;

  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
      stream: _databaseService.todos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Todo> todos = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index];
              final DateTime dt = todo.timeStamp.toDate();
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  key: ValueKey(todo.id),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      CustomSlidableAction(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done),
                            Text(
                              "Mark as done",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        onPressed: (context) async {
                          await _databaseService.deleteTodoTask(todo.id);
                        },
                      ),
                    ],
                  ),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      CustomSlidableAction(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit),
                            Text(
                              "Edit",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        onPressed: (context) {
                          showTaskDialog(context, todo: todo);
                        },
                      ),
                      CustomSlidableAction(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete),
                            Text(
                              "Delete",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        onPressed: (context) async {
                          await _databaseService.deleteTodoTask(todo.id);
                        },
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      todo.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(todo.description),
                    trailing: Text(
                      '${dt.day}/${dt.month}/${dt.year}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }
      },
    );
  }
}
