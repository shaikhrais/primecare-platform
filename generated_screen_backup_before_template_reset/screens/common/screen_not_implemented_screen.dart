// Governance - Category: view | Purpose: Coordinator layout for Screen Not Implemented
// TODO: Implement screen coordinator layout according to DB requirements.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenNotImplementedScreen extends ConsumerWidget {
  const ScreenNotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Screen Not Implemented Coordinator'),
      ),
    );
  }
}
