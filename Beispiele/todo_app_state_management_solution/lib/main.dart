import 'package:flutter/material.dart';
import 'package:todo_app_state_management_solution/todo_filter.dart';
import 'package:todo_app_state_management_solution/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App - State Management (Solution)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo App - State Management (Solution)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _filterIndex = 0;

  void _setFilterIndex(int index) {
    setState(() {
      _filterIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TodoFilter(
              setFilter: _setFilterIndex,
              filterIndex: _filterIndex,
            ),
            TodoList(filterIndex: _filterIndex),
          ],
        ),
      ),
    );
  }
}
