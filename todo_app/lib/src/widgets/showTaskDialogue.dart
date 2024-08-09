import 'package:flutter/material.dart';
import 'package:todo_app/src/models/todo_model.dart';
import 'package:todo_app/src/services/database_service.dart';

void showTaskDialog(BuildContext context, {Todo? todo}) {
  final TextEditingController titleController =
      TextEditingController(text: todo?.title);
  final TextEditingController descriptionController =
      TextEditingController(text: todo?.description);
  final DatabaseService databaseService = DatabaseService();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          todo == null ? "Add task" : "Edit task",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (todo == null) {
                await databaseService.addTodoTask(
                    titleController.text, descriptionController.text);
              } else {
                await databaseService.updateTodo(
                    todo.id, titleController.text, descriptionController.text);
              }
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: Text(todo == null ? "Add" : "Update"),
          ),
        ],
      );
    },
  );
}
