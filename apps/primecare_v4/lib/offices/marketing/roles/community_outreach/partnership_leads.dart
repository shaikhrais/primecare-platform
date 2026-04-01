import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class PartnershipLeadsView extends StatelessWidget {
  const PartnershipLeadsView({Key? key}) : super(key: key);

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
            Text('Community Partnership Hub', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildLeadCard('St. Jude Regional Hospital', 'Type: Institutional', 'ACTIVE PARTNER', Colors.teal),
            const SizedBox(height: 16),
            _buildLeadCard('West End Retirement Center', 'Type: Community Group', 'NEGOTIATION', Colors.orange),
            const SizedBox(height: 16),
            _buildLeadCard('North Star Wellness Initiative', 'Type: NGO', 'PROSPECT', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadCard(String name, String type, String status, Color color) {
    return GlassSurface(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Icon(Icons.handshake_outlined, color: color, size: 28),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(type, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
              ],
            ),
          ),
          Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}
