import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/task_store.dart';
import 'add_task_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TaskStore store = TaskStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ToDo App"), centerTitle: true),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: store.tasks.length,
          itemBuilder: (_, index) {
            final task = store.tasks[index];
            return CheckboxListTile(
              title: Text(task.title),
              subtitle: Text(
                "${task.priority}  ${task.date.day}/${task.date.month}/${task.date.year}",
              ),
              value: task.isDone,
              onChanged: (_) => store.toggleTask(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskPage(store: store)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
