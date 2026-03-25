import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorHubScreen extends StatelessWidget {
  const CoordinatorHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dispatch Hub')),
      body: Column(
        children: [
          const LiveDispatchMap(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Waitlist Kanban',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: KanbanWaitlistBoard(),
          ),
          const Spacer(),
          const Text('Drag PSW to Assign:'),
          const SizedBox(height: 16),
          const DragAssignWidget(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
