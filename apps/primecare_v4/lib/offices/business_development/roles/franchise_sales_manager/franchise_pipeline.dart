import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class FranchisePipelineView extends StatelessWidget {
  const FranchisePipelineView({Key? key}) : super(key: key);

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
            Text('Strategic Franchise Expansion', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildProspectRow('Prospect: Metro Toronto East', 'Stage: Legal Review', '90%', Colors.teal),
            _buildProspectRow('Prospect: Calgary North Hub', 'Stage: Initial Deposit', '45%', Colors.orange),
            _buildProspectRow('Prospect: Halifax Regional', 'Stage: Discovery Day', '25%', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildProspectRow(String label, String stage, String prob, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.storefront_outlined, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(stage, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                ],
              ),
            ),
            Text(prob, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
