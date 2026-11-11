import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/material.dart';

class ArchitecturePlanningDashboardHeaderSection extends StatelessWidget {
  final Map<String, dynamic> data;
  const ArchitecturePlanningDashboardHeaderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'architectureplanningdashboard_title',
      container: true,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Architecture & Technology Workspace', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Welcome back, Chief Architect.', style: TextStyle(color: context.theme.colors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
