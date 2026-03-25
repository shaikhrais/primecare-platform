import 'package:flutter/material.dart';

class UniversalChatThreadScreen extends StatelessWidget {
  final String rolePrefix;
  final String threadId;
  const UniversalChatThreadScreen({
    super.key,
    required this.rolePrefix,
    required this.threadId,
  });
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Chat Thread')));
}
