import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterDashboardScreen extends StatelessWidget {
  const ScrumMasterDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: AppBar(
        title: const Text('SCM_GOD_MODE_HUB', style: TextStyle(color: PrimeCareColors.emerald, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.hub_rounded, size: 64, color: Color(0xFF3B82F6)),
            const SizedBox(height: 16),
            const Text(
              'PLATFORM TELEMETRY',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildMetricCard('Postgres Active Tenants', '142', Icons.apartment, PrimeCareColors.emerald),
            _buildMetricCard('Cloudflare API Requests/sec', '9,420', Icons.speed, const Color(0xFF3B82F6)),
            _buildMetricCard('WebRTC Active Sessions', '314', Icons.video_camera_front, PrimeCareColors.purple),
            _buildMetricCard('Unresolved System Exceptions', '0', Icons.bug_report, PrimeCareColors.rose),
          ],
        ),
      ),
      ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      backgroundColor: PrimeCareColors.slate800,
      child: Row(
        children: [
          PrimeCareCard(
            padding: const EdgeInsets.all(12),
            backgroundColor: color.withAlpha(25),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, fontFamily: 'monospace')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
