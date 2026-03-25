import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswLiveVisitScreen extends StatelessWidget {
  const PswLiveVisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Visit: Eleanor Rigby')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const LiveGeolocationMapLoader(),
            const SizedBox(height: 20),
            const SlideToClockInWidget(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  TaskChecklistNode(label: 'Administer Morning Meds'),
                  TaskChecklistNode(label: 'Assist with Bathing'),
                  TaskChecklistNode(label: 'Prepare Breakfast'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const IncidentReportFab(),
    );
  }
}
