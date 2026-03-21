import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';

class ScrumMasterSecurityScreen extends StatelessWidget {
  const ScrumMasterSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: AppBar(
        title: const Text('SCM_SECURITY_OPS', style: TextStyle(color: PrimeCareColors.rose, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('ACTIVE THREAT VECTORS', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 16),
          _buildThreatTile('Anomalous Login Detected', 'IP: 192.168.1.104 (Toronto) failing 15 JWT auth evaluations per minute. Blocked implicitly at CDN level.', '12 mins ago'),
          _buildThreatTile('Malicious Payload Rejected', 'Middleware intercepted a SQL injection attempt directed at /v1/user/dispatch/surge.', '42 mins ago'),
          
          const SizedBox(height: 48),
          const Text('SYSTEM FIREWALL STATUS', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 16),
          _buildFirewallTile('WAF Rule: Strict Rate Limiting', true),
          _buildFirewallTile('WAF Rule: Geo-Blocking Non-NA Regions', true),
          _buildFirewallTile('Middleware: JWT Issuer Whitelisting', true),
          _buildFirewallTile('Middleware: Strict Payload Sanitization', true),
        ],
      )
        ),
      ),
    );
  }

  Widget _buildThreatTile(String title, String desc, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate800,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4C1D95)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.shield_rounded, color: PrimeCareColors.rose, size: 24),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
              Text(time, style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(desc, style: const TextStyle(color: PrimeCareColors.slate400, height: 1.5)),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('ISOLATE NODE', style: TextStyle(color: PrimeCareColors.rose, fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFirewallTile(String title, bool active) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: PrimeCareColors.radarDark,
        border: Border.all(color: PrimeCareColors.slate800),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: PrimeCareColors.slate200)),
          Icon(active ? Icons.security_rounded : Icons.gpp_bad_rounded, color: active ? PrimeCareColors.emerald : PrimeCareColors.rose),
        ],
      ),
    );
  }
}
