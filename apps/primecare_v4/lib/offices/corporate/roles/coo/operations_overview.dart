import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class OperationsOverviewView extends StatelessWidget {
  const OperationsOverviewView({Key? key}) : super(key: key);

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
            Text('Systemic Operations Overview', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildMetric('Institutional Occupancy Rate', '94.2%', Colors.teal),
            _buildMetric('Regional Care Quality Score', '8.9/10', Colors.indigo),
            _buildMetric('Operational Expenditure Sync', 'Optimized', Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.speed_outlined, color: color),
            const SizedBox(width: 24),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
