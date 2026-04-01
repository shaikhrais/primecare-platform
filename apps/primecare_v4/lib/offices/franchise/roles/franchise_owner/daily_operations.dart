import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class DailyOperationsView extends StatelessWidget {
  const DailyOperationsView({Key? key}) : super(key: key);

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
            Text('Daily Institutional Oversight', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildOpsRow('Facility Readiness (Toronto West)', '98%', Colors.teal),
            _buildOpsRow('Active Clinical Shift Count', '14 Active', Colors.indigo),
            _buildOpsRow('Supply Chain: PPE / Medical', 'Stable', Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildOpsRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.business_center_outlined, color: color),
            const SizedBox(width: 24),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
