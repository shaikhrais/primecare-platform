import 'package:flutter/material.dart';

class UniversalTimelineScreen extends StatelessWidget {
  final String rolePrefix;
  const UniversalTimelineScreen({super.key, required this.rolePrefix});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Timeline Screen')));
}
