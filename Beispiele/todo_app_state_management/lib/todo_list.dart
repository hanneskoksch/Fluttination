import 'package:flutter/material.dart';
import 'package:todo_app_state_management/todo_item_model.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<TodoItem> _items = [
    TodoItem(title: 'Ausweis validieren'),
    TodoItem(title: 'Von Flutter faszinieren lassen'),
    TodoItem(title: 'Hausaufgaben machen'),
    TodoItem(title: 'Flutter-App entwickeln'),
    TodoItem(title: 'Flutter-App testen'),
    TodoItem(title: 'Flutter-App veröffentlichen'),
    TodoItem(title: 'Brot essen'),
    TodoItem(title: 'Einrad fahren'),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            title: Text(item.title),
            leading: Checkbox(
              value: item.isDone,
              onChanged: (value) {
                setState(() {
                  _items[index] = TodoItem(
                    title: item.title,
                    isDone: value!,
                  );
                });
              },
            ),
          );
        },
      ),
    );
  }
}
