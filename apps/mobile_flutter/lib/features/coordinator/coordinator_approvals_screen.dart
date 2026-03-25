import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorApprovalsScreen extends StatelessWidget {
  const CoordinatorApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timesheet Approvals Stack')),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: TinderStyleSwipeApprovals()),
      ),
    );
  }
}
