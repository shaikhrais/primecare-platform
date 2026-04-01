import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class CareUpdatesView extends StatelessWidget {
  const CareUpdatesView({Key? key}) : super(key: key);

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
            Text('Real-time Care Updates', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildUpdateItem('Arthur Dent: Vitals Stable', 'RN Assessment completed at 02:00 PM.', '2h ago', Colors.teal),
            _buildUpdateItem('Arthur Dent: Meal Intake', 'High intake reported for lunch session.', '4h ago', Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String title, String desc, String time, Color color) {
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
