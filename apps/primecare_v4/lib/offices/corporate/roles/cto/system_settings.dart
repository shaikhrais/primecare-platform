import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class SystemSettingsView extends StatelessWidget {
  const SystemSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Global Infrastructure Settings', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
          const SizedBox(height: 24),
          _buildSysSetting('API Rate Limiting', 'Tier: Professional (10k req/min)', Colors.teal),
          _buildSysSetting('Edge Node Distribution', 'Global (142 Nodes Active)', Colors.indigo),
          _buildSysSetting('Database Sharding Status', 'Stable (Regional: NA-East)', Colors.teal),
          _buildSysSetting('AI Model Quantization', '4-bit (Flash Optimized)', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildSysSetting(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.settings_suggest_outlined, color: color),
            const SizedBox(width: 24),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
