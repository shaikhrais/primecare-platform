import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class PipelineView extends StatelessWidget {
  const PipelineView({Key? key}) : super(key: key);

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
            Text('Territory Expansion Pipeline', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildPipelineItem('Lead: West GTA Portfolio', 'Stage: Qualify', '85%', Colors.teal),
            const Divider(height: 32, thickness: 0.1),
            _buildPipelineItem('Lead: Oakville Clinic Hub', 'Stage: Proposal', '45%', Colors.orange),
            const Divider(height: 32, thickness: 0.1),
            _buildPipelineItem('Lead: Burlington Care Center', 'Stage: Closed', '100%', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineItem(String label, String stage, String prob, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 12, backgroundColor: color.withOpacity(0.1), child: Icon(Icons.rocket_launch, size: 14, color: color)),
        const SizedBox(width: 16),
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
    );
  }
}
