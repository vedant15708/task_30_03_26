import 'package:flutter/material.dart';
import 'package:task_30_03_26/values/values/export.dart';
import '../model/task_model.dart';
import '../store/task_store.dart';

class AddTaskPage extends StatefulWidget {
  final TaskStore store;
  const AddTaskPage({super.key, required this.store});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleCtrl = TextEditingController();
  final ValueNotifier<DateTime?> selectedDate = ValueNotifier(null);
  final ValueNotifier<String?> selectedPriority = ValueNotifier(null);
  final List<String> priorityList = ["Low", "Medium", "High"];

  @override
  void dispose() {
    titleCtrl.dispose();
    selectedDate.dispose();
    selectedPriority.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task"), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: titleCtrl,
            decoration: const InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(),
            ),
          ),
          20.verticalSpace,
          ValueListenableBuilder(
            valueListenable: selectedDate,
            builder: (context, value, child) {
              return InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now(),
                  );
                  if (date != null) {
                    selectedDate.value = date;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value == null
                            ? "Select Date"
                            : "${value.day}/${value.month}/${value.year}",
                      ),
                      const Icon(Icons.calendar_month),
                    ],
                  ),
                ),
              );
            },
          ),
          20.verticalSpace,
          ValueListenableBuilder(
            valueListenable: selectedPriority,
            builder: (context, value, child) {
              return DropdownButtonFormField<String>(
                value: value,
                decoration: const InputDecoration(
                  labelText: "Priority",
                  border: OutlineInputBorder(),
                ),
                items: priorityList
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (val) {
                  selectedPriority.value = val;
                },
              );
            },
          ),
          30.verticalSpace,
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.isEmpty ||
                  selectedDate.value == null ||
                  selectedPriority.value == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields")),
                );
                return;
              }
              widget.store.addTask(
                TaskModel(
                  title: titleCtrl.text.trim(),
                  date: selectedDate.value!,
                  priority: selectedPriority.value!,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text("Add Task"),
          ),
        ],
      ).wrapPaddingAll(16),
    );
  }
}
