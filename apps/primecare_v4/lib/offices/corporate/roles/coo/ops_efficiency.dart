import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class OpsEfficiencyView extends StatelessWidget {
  const OpsEfficiencyView({Key? key}) : super(key: key);

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
            Text('Operational Efficiency HUD', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildEffItem('Global Staff Utilization', '88%'),
            _buildEffItem('Regional Margin (Ontario)', '24.2%'),
            _buildEffItem('Incident Resolution Time', '2.4h'),
          ],
        ),
      ),
    );
  }

  Widget _buildEffItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.analytics_outlined, color: AppTheme.primary),
            const SizedBox(width: 20),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary)),
          ],
        ),
      ),
    );
  }
}
