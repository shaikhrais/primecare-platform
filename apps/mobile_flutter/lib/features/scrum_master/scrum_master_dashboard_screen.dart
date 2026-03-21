import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterDashboardScreen extends StatelessWidget {
  const ScrumMasterDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: PrimeCareText('SCM_GOD_MODE_HUB', style: TextStyle(color: PrimeCareColors.emerald, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareScrollWrapper(
            padding: EdgeInsets.all(24),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrimeCareIcon(Icons.hub_rounded, size: 64, color: Color(0xFF3B82F6)),
            PrimeCareSizedBox(height: 16),
            PrimeCareText(
              'PLATFORM TELEMETRY',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 2),
              textAlign: TextAlign.center,
            ),
            PrimeCareSizedBox(height: 40),
            _buildMetricCard('Postgres Active Tenants', '142', Icons.apartment, PrimeCareColors.emerald),
            _buildMetricCard('Cloudflare API Requests/sec', '9,420', Icons.speed, Color(0xFF3B82F6)),
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
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      backgroundColor: PrimeCareColors.slate800,
      child: PrimeCareRow(
        children: [
          PrimeCareCard(
            padding: EdgeInsets.all(12),
            backgroundColor: color.withAlpha(25),
            child: PrimeCareIcon(icon, color: color, size: 32),
          ),
          PrimeCareSizedBox(width: 20),
          PrimeCareExpanded(
            child: PrimeCareColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareText(title, style: TextStyle(color: PrimeCareColors.slate400, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                PrimeCareSizedBox(height: 4),
                PrimeCareText(value, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, fontFamily: 'monospace')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
