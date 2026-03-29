import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class IncidentReportScreen extends StatelessWidget {
  const IncidentReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Report'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
             PrimeCareCard(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   const Text('Report Critical / Adverse Event', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
                   const SizedBox(height: 16),
                   DropdownButtonFormField<String>(
                     decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Incident Classification'),
                     items: const [
                       DropdownMenuItem(value: 'Fall', child: Text('Patient Fall')),
                       DropdownMenuItem(value: 'Injury', child: Text('Physical Injury')),
                       DropdownMenuItem(value: 'MedRefusal', child: Text('Medication Refusal / Error')),
                       DropdownMenuItem(value: 'Aggression', child: Text('Aggressive Behavior')),
                     ],
                     onChanged: (val) {},
                   ),
                   const SizedBox(height: 16),
                   TextFormField(
                     maxLines: 4,
                     decoration: const InputDecoration(
                       labelText: 'What happened? Action Taken?',
                       border: OutlineInputBorder(),
                     ),
                   ),
                   const SizedBox(height: 16),
                   PrimeCareButton(
                     onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incident flagged and escalated to RN Supervisor immediately.')));
                         context.pop();
                     },
                     icon: Icons.warning_amber_rounded,
                     label: 'ESCALATE TO RN SUPERVISOR',
                     isFullWidth: true,
                   ),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }
}
