import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class CarePlansView extends StatelessWidget {
  const CarePlansView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RPN Care Navigation & Goals', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildGoalRow('Daily Blood Glucose Monitoring', '90%', Colors.teal),
            _buildGoalRow('Post-Op Wound Healing Sync', '45%', Colors.orange),
            _buildGoalRow('Mobilization Level 2 achieved', 'DONE', Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalRow(String label, String progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
             Icon(Icons.flag_outlined, color: color),
             const SizedBox(width: 20),
             Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
             Text(progress, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
