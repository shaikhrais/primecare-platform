import 'package:flutter/material.dart';

class UniversalInboxScreen extends StatelessWidget {
  final String rolePrefix;
  const UniversalInboxScreen({super.key, required this.rolePrefix});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Inbox Screen')));
}
