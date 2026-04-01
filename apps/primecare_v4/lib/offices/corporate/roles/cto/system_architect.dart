import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class SystemArchitectView extends StatelessWidget {
  const SystemArchitectView({Key? key}) : super(key: key);

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
            Text('System Architecture Health', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildSysMetric('Edge Cloudflare Cluster', '99.99%', true),
            _buildSysMetric('Prisma Postgres DB Hub', 'Healthy', true),
            _buildSysMetric('AI Inference Worker', 'Calibrating', false),
            const SizedBox(height: 32),
            const GlassSurface(
              padding: EdgeInsets.all(24),
              child: Text('Live Topology Feed: Synchronizing region us-east-1 with local worker nodes.', style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.indigo)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSysMetric(String title, String value, bool ok) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(ok ? Icons.check_circle : Icons.warning, color: ok ? Colors.teal : Colors.orange),
            const SizedBox(width: 20),
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: ok ? Colors.teal : Colors.orange)),
          ],
        ),
      ),
    );
  }
}
