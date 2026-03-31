import 'package:mobx/mobx.dart';
part 'task_model.g.dart';

class TaskModel = _TaskModel with _$TaskModel;

abstract class _TaskModel with Store {
  @observable
  String title;

  @observable
  DateTime date;

  @observable
  String priority;

  @observable
  bool isDone;

  _TaskModel({
    required this.title,
    required this.date,
    required this.priority,
    this.isDone = false,
  });
}
