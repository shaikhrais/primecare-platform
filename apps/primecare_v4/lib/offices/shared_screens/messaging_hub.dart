import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../office/components/glass_surface.dart';

class MessagingHubScreen extends StatelessWidget {
  const MessagingHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Secure Messaging Hub', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildActiveThread(context, 'Dr. Aris Thorne', 'Regarding Arthur Dent Discharge Plan', '2m ago', true),
          _buildActiveThread(context, 'Internal: HR Cluster', 'Broadcast: New Compliance Guidelines', '1h ago', false),
          _buildActiveThread(context, 'Support Nexus', 'TCK-2041 Resolution Confirmation', '3h ago', false),
        ],
      ),
    );
  }

  Widget _buildActiveThread(BuildContext context, String sender, String subject, String time, bool unread) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundColor: AppTheme.primary.withOpacity(0.1), child: Text(sender[0])),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sender, style: TextStyle(fontWeight: unread ? FontWeight.bold : FontWeight.normal)),
                  Text(subject, style: const TextStyle(color: Colors.blueGrey, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Text(time, style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
          ],
        ),
      ),
    );
  }
}
