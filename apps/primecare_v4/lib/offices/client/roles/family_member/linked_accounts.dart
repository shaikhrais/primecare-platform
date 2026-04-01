import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class LinkedAccountsView extends StatelessWidget {
  const LinkedAccountsView({Key? key}) : super(key: key);

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
            Text('Linked Patient Profiles', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildLinkCard('Arthur Dent', 'Active Care Plan', 'FULL ACCESS', Colors.teal),
            const SizedBox(height: 16),
            _buildLinkCard('Tricia McMillan', 'Initial Intake', 'VIEW ONLY', Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkCard(String name, String status, String access, Color color) {
    return GlassSurface(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          CircleAvatar(radius: 20, backgroundColor: color.withOpacity(0.1), child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold))),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(status, style: const TextStyle(color: Colors.blueGrey, fontSize: 14)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
            child: Text(access, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
