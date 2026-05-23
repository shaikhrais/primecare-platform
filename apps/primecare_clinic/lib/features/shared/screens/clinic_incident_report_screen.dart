// Governance - Category: view | Purpose: UI Screen component rendering the Clinic Incident Report Screen workspace interface.
import 'package:flutter/material.dart';

class ClinicIncidentReportScreen extends StatelessWidget {
  const ClinicIncidentReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Safety Incident Report', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: 'Incident Title', border: OutlineInputBorder(), prefixIcon: Icon(Icons.warning))),
            const SizedBox(height: 16),
            const Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Detailed Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Submit to Safety Officer'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}