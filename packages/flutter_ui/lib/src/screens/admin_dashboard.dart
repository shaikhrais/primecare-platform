import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard (Deprecated)'),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          'This legacy dashboard is deprecated. Please use the modular role-specific dashboards.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
