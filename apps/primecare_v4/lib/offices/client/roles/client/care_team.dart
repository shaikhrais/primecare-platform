import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class CareTeamView extends StatelessWidget {
  const CareTeamView({Key? key}) : super(key: key);

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
            Text('My Dedicated Care Team', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildTeamRow('Dr. Aris Thorne', 'Primary Physician', Colors.teal),
            _buildTeamRow('RN Arthur Dent', 'Registered Nurse', Colors.indigo),
            _buildTeamRow('PSW Ford Prefect', 'Personal Support', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamRow(String name, String role, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundColor: color.withOpacity(0.1), child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold))),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(role, style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.chat_bubble_outline, color: color, size: 20), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
