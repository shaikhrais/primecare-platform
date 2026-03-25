import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterSecurityScreen extends StatelessWidget {
  const ScrumMasterSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,

      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
            padding: EdgeInsets.all(24),
            children: [
              PrimeCareText(
                'ACTIVE THREAT VECTORS',
                style: TextStyle(
                  color: PrimeCareColors.slate400,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 16),
              _buildThreatTile(
                'Anomalous Login Detected',
                'IP: 192.168.1.104 (Toronto) failing 15 JWT auth evaluations per minute. Blocked implicitly at CDN level.',
                '12 mins ago',
              ),
              _buildThreatTile(
                'Malicious Payload Rejected',
                'Middleware intercepted a SQL injection attempt directed at /v1/user/dispatch/surge.',
                '42 mins ago',
              ),

              SizedBox(height: 48),
              PrimeCareText(
                'SYSTEM FIREWALL STATUS',
                style: TextStyle(
                  color: PrimeCareColors.slate400,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 16),
              _buildFirewallTile('WAF Rule: Strict Rate Limiting', true),
              _buildFirewallTile('WAF Rule: Geo-Blocking Non-NA Regions', true),
              _buildFirewallTile('Middleware: JWT Issuer Whitelisting', true),
              _buildFirewallTile(
                'Middleware: Strict Payload Sanitization',
                true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThreatTile(String title, String desc, String time) {
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),

      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            children: [
              PrimeCareIcon(
                Icons.shield_rounded,
                color: PrimeCareColors.rose,
                size: 24,
              ),
              SizedBox(width: 12),
              PrimeCareExpanded(
                child: PrimeCareText(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              PrimeCareText(
                time,
                style: TextStyle(color: PrimeCareColors.slate500, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 12),
          PrimeCareText(
            desc,
            style: TextStyle(color: PrimeCareColors.slate400, height: 1.5),
          ),
          SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: PrimeCareButton(
              type: PrimeCareButtonType.text,
              onPressed: () {},
              child: PrimeCareText(
                'ISOLATE NODE',
                style: TextStyle(
                  color: PrimeCareColors.rose,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirewallTile(String title, bool active) {
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareText(
            title,
            style: TextStyle(color: PrimeCareColors.slate200),
          ),
          PrimeCareIcon(
            active ? Icons.security_rounded : Icons.gpp_bad_rounded,
            color: active ? PrimeCareColors.emerald : PrimeCareColors.rose,
          ),
        ],
      ),
    );
  }
}
