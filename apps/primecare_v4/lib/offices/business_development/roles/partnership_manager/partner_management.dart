import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class PartnerManagementView extends StatelessWidget {
  const PartnerManagementView({Key? key}) : super(key: key);

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
            Text('Institutional Partnership Management', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildPartnerRow('St. Jude Health Network', 'ACTIVE', '98%', Colors.teal),
            _buildPartnerRow('Ontario Wellness Alliance', 'NEGOTIATION', '45%', Colors.orange),
            _buildPartnerRow('Global Care Initiative', 'PROSPECT', '15%', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerRow(String name, String status, String impact, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.handshake_outlined, color: color),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Institutional Status: $status', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
                ],
              ),
            ),
            Text(impact, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
