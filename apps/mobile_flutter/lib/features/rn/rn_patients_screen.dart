import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RnPatientsScreen extends StatelessWidget {
  const RnPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Roster')),
      body: Column(
        children: [
          const SearchFilterTabBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                PatientAcuityCard(name: 'Eleanor Rigby', acuityLevel: 3),
                SizedBox(height: 12),
                PatientAcuityCard(name: 'John Doe', acuityLevel: 2),
                SizedBox(height: 12),
                PatientAcuityCard(name: 'Alice Smith', acuityLevel: 1),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const QuickCallButton(),
    );
  }
}
