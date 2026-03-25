import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AdminTelemetryScreen extends StatelessWidget {
  const AdminTelemetryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('System Telemetry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            ServerLoadGraph(),
            SizedBox(height: 24),
            ActiveWebSocketTracker(),
          ],
        ),
      ),
    );
  }
}
