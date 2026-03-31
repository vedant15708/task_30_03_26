import 'package:mobx/mobx.dart';
import '../model/task_model.dart';
part 'task_store.g.dart';

class TaskStore = _TaskStore with _$TaskStore;

abstract class _TaskStore with Store {
  @observable
  ObservableList<TaskModel> tasks = ObservableList<TaskModel>();

  int _priorityValue(String priority) {
    switch (priority) {
      case "High":
        return 3;
      case "Medium":
        return 2;
      case "Low":
      default:
        return 1;
    }
  }

  @action
  void _sortTasks() {
    tasks.sort(
      (a, b) =>
          _priorityValue(b.priority).compareTo(_priorityValue(a.priority)),
    );
  }

  @action
  void addTask(TaskModel task) {
    tasks.add(task);
    _sortTasks();
  }

  @action
  void toggleTask(int index) {
    final task = tasks[index];

    tasks[index] = TaskModel(
      title: task.title,
      date: task.date,
      priority: task.priority,
      isDone: !task.isDone,
    );
  }
}
