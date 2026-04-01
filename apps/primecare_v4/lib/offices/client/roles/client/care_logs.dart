import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class CareLogsView extends StatelessWidget {
  const CareLogsView({Key? key}) : super(key: key);

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
            Text('My Care Timeline', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildLogItem('Physical Therapy Session', 'Completed by Physio Slartibartfast.', '2h ago', Colors.teal),
            _buildLogItem('Medication Supervision', 'AM dosage successfully administered.', '4h ago', Colors.indigo),
            _buildLogItem('Meal Intake: High', 'Patient consumed full meal with proper hydration.', '8h ago', Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildLogItem(String title, String desc, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13)),
                const Spacer(),
                Text(time, style: const TextStyle(color: Colors.blueGrey, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
