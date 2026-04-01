import 'package:flutter/material.dart';
import '../../office/components/glass_surface.dart';
import '../../core/theme/app_theme.dart';

class GlobalSettingsScreen extends StatelessWidget {
  const GlobalSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('System Preferences', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSettingTile('Biometric Authentication', 'Enable FaceID/TouchID for quick access.', true),
          _buildSettingTile('Institutional Notifications', 'Receive real-time alerts for priority updates.', true),
          _buildSettingTile('Cloud Sync: Edge Performance', 'Optimize data hydration via closest worker node.', true),
          _buildSettingTile('Dark Mode: Luminous Interface', 'Reduce eye strain during clinical cycles.', true),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, String sub, bool val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(sub, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                ],
              ),
            ),
            Switch.adaptive(value: val, onChanged: (v) {}, activeColor: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
