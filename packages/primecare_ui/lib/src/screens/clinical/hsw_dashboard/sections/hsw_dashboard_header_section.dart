import 'package:flutter/material.dart';

class HswDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const HswDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'hswdashboard_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Home Support Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Welcome back, Care Worker.', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
