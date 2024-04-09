import 'package:flutter/material.dart';

class TodoFilter extends StatefulWidget {
  const TodoFilter({super.key});

  @override
  State<TodoFilter> createState() => _TodoFilterState();
}

class _TodoFilterState extends State<TodoFilter> {
  int _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text("Filter: "),
          const SizedBox(
            width: 8,
          ),
          FilterChip(
            label: const Text("All"),
            onSelected: (value) {
              setState(() {
                _filterIndex = 0;
              });
            },
            selected: _filterIndex == 0,
          ),
          const SizedBox(
            width: 8,
          ),
          FilterChip(
            label: const Text("Done"),
            onSelected: (value) {
              setState(() {
                _filterIndex = 1;
              });
            },
            selected: _filterIndex == 1,
          ),
          const SizedBox(
            width: 8,
          ),
          FilterChip(
            label: const Text("Undone"),
            onSelected: (value) {
              setState(() {
                _filterIndex = 2;
              });
            },
            selected: _filterIndex == 2,
          ),
        ],
      ),
    );
  }
}
