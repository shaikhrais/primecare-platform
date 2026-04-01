import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../office/components/glass_surface.dart';

class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Institutional Alerts', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildAlert('SYSTEM ALERT', 'Maintenance scheduled for 02:00 AM UTC.', 'PRIORITY: MED', Colors.orange),
          _buildAlert('CLINICAL SYNC', 'New Lab Results available for Arthur Dent.', 'ACTION REQ', Colors.teal),
          _buildAlert('SECURITY HUB', 'New VPN range detected for Toronto West.', 'INFO', Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildAlert(String cat, String msg, String tag, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(cat, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 10, letterSpacing: 1.2)),
                const Spacer(),
                Text(tag, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 9)),
              ],
            ),
            const SizedBox(height: 12),
            Text(msg, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
