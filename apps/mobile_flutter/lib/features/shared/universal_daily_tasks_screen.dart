import 'package:flutter/material.dart';

class UniversalDailyTasksScreen extends StatelessWidget {
  final String rolePrefix;
  const UniversalDailyTasksScreen({super.key, required this.rolePrefix});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Daily Tasks')));
}
