import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/src/services/database_service.dart';

import '../models/todo_model.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({super.key});

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
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
      stream: _databaseService.completedTodos,
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
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  key: ValueKey(todo.id),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
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
                        //borderRadius: BorderRadius.circular(10),
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
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
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
