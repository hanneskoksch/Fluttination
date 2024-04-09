import 'package:flutter/material.dart';
import 'package:todo_app_state_management_solution/todo_item_model.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.filterIndex});

  final int filterIndex;

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

  List<TodoItem> get _filteredItems {
    switch (widget.filterIndex) {
      case 1:
        return _items.where((item) => item.isDone).toList();
      case 2:
        return _items.where((item) => !item.isDone).toList();
      default:
        return _items;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
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
