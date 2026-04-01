import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class TerritoryTrackingView extends StatelessWidget {
  const TerritoryTrackingView({Key? key}) : super(key: key);

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
            Text('US National Expansion HUD', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildTerritoryRow('Florida Regional Hub', '98% COVERAGE', Colors.teal),
            _buildTerritoryRow('California Coastal Cluster', '65% COVERAGE', Colors.orange),
            _buildTerritoryRow('Texas Strategic Reach', '22% COVERAGE', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildTerritoryRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
             Icon(Icons.public_outlined, color: color),
             const SizedBox(width: 24),
             Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
             Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
