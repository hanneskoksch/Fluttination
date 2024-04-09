import 'package:flutter/material.dart';

class TodoFilter extends StatefulWidget {
  const TodoFilter({
    super.key,
    required this.setFilter,
    required this.filterIndex,
  });

  final void Function(int) setFilter;
  final int filterIndex;

  @override
  State<TodoFilter> createState() => _TodoFilterState();
}

class _TodoFilterState extends State<TodoFilter> {
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
            onSelected: (_) {
              widget.setFilter(0);
            },
            selected: widget.filterIndex == 0,
          ),
          const SizedBox(
            width: 8,
          ),
          FilterChip(
            label: const Text("Done"),
            onSelected: (_) {
              widget.setFilter(1);
            },
            selected: widget.filterIndex == 1,
          ),
          const SizedBox(
            width: 8,
          ),
          FilterChip(
            label: const Text("Undone"),
            onSelected: (_) {
              widget.setFilter(2);
            },
            selected: widget.filterIndex == 2,
          ),
        ],
      ),
    );
  }
}
