import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientCareTeamScreen extends StatelessWidget {
  const ClientCareTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Care Team')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            EtaTrackerWidget(),
            SizedBox(height: 24),
            Text(
              'Assigned Caregivers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CaregiverProfileCard(),
            SizedBox(height: 12),
            CaregiverProfileCard(),
          ],
        ),
      ),
    );
  }
}
