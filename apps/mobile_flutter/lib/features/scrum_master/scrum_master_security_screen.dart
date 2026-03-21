import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterSecurityScreen extends StatelessWidget {
  const ScrumMasterSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('SCM_SECURITY_OPS', style: TextStyle(color: PrimeCareColors.rose, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PrimeCareText('ACTIVE THREAT VECTORS', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const PrimeCareSizedBox(height: 16),
          _buildThreatTile('Anomalous Login Detected', 'IP: 192.168.1.104 (Toronto) failing 15 JWT auth evaluations per minute. Blocked implicitly at CDN level.', '12 mins ago'),
          _buildThreatTile('Malicious Payload Rejected', 'Middleware intercepted a SQL injection attempt directed at /v1/user/dispatch/surge.', '42 mins ago'),
          
          const PrimeCareSizedBox(height: 48),
          const PrimeCareText('SYSTEM FIREWALL STATUS', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const PrimeCareSizedBox(height: 16),
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
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            children: [
              const PrimeCareIcon(Icons.shield_rounded, color: PrimeCareColors.rose, size: 24),
              const PrimeCareSizedBox(width: 12),
              PrimeCareExpanded(child: PrimeCareText(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
              PrimeCareText(time, style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 12)),
            ],
          ),
          const PrimeCareSizedBox(height: 12),
          PrimeCareText(desc, style: const TextStyle(color: PrimeCareColors.slate400, height: 1.5)),
          const PrimeCareSizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: PrimeCareButton(type: PrimeCareButtonType.text, 
              onPressed: () {},
              child: const PrimeCareText('ISOLATE NODE', style: TextStyle(color: PrimeCareColors.rose, fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFirewallTile(String title, bool active) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareText(title, style: const TextStyle(color: PrimeCareColors.slate200)),
          PrimeCareIcon(active ? Icons.security_rounded : Icons.gpp_bad_rounded, color: active ? PrimeCareColors.emerald : PrimeCareColors.rose),
        ],
      ),
    );
  }
}
