import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class CeoSettingsView extends StatelessWidget {
  const CeoSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Executive System Preferences', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
          const SizedBox(height: 24),
          _buildCeoSetting('Biometric Auth Mastery', 'Secure all high-level institutional data.', true),
          _buildCeoSetting('Real-time Regional Alerts', 'Priority notifications for all 37 roles.', true),
        ],
      ),
    );
  }

  Widget _buildCeoSetting(String title, String sub, bool val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(sub, style: const TextStyle(color: Colors.blueGrey, fontSize: 12))])),
            Switch.adaptive(value: val, onChanged: (v) {}, activeColor: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
