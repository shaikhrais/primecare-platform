import 'package:flutter/material.dart';

class IncidentReportFab extends StatelessWidget {
  const IncidentReportFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: Colors.red.shade600,
      icon: const Icon(Icons.warning, color: Colors.white),
      label: const Text(
        'REPORT INCIDENT',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
