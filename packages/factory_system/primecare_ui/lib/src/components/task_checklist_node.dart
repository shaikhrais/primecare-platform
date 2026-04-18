import 'package:primecare_ui/src/theme/colors.dart';
// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class TaskChecklistNode extends StatefulWidget {
  final String label;
  const TaskChecklistNode({super.key, required this.label});
  @override
  _TaskChecklistNodeState createState() => _TaskChecklistNodeState();
}

class _TaskChecklistNodeState extends State<TaskChecklistNode> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isChecked,
      onChanged: (val) => setState(() => isChecked = val ?? false),
      title: Text(
        widget.label,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
          color: isChecked
              ? PrimeCareColors.slate400
              : PrimeCareColors.black.withValues(alpha: 0.87),
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
