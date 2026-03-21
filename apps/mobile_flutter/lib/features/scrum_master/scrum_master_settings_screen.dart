import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterSettingsScreen extends StatefulWidget {
  const ScrumMasterSettingsScreen({super.key});

  @override
  State<ScrumMasterSettingsScreen> createState() => _ScrumMasterSettingsScreenState();
}

class _ScrumMasterSettingsScreenState extends State<ScrumMasterSettingsScreen> {
  bool _mockOffline = false;
  bool _forceSurge = false;
  bool _logSQL = true;

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('SCM_GLOBAL_CONFIG', style: TextStyle(color: PrimeCareColors.amber, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
        padding: const EdgeInsets.all(24),
        children: [
          const PrimeCareText('ENVIRONMENT OVERRIDES', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const PrimeCareSizedBox(height: 16),
          _buildToggle(
            'Force Offline Mode (CRDT Sync Test)', 
            'Simulate a total Cloudflare outage to strictly test local SQLite cache buffers natively.', 
            _mockOffline, 
            (val) => setState(() => _mockOffline = val)
          ),
          _buildToggle(
            'Global Surge Pricing Toggle', 
            'Force the algorithm to deploy 2.5x EVV multipliers across all active unbilled shifts universally.', 
            _forceSurge, 
            (val) => setState(() => _forceSurge = val)
          ),
          _buildToggle(
            'Verbose Prisma SQL Logging', 
            'Pipe raw abstract SQL database arrays actively into the Cloudflare tail streams to analyze index efficiency.', 
            _logSQL, 
            (val) => setState(() => _logSQL = val)
          ),

          const PrimeCareSizedBox(height: 48),
          const PrimeCareText('ADMIN ACTIONS', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const PrimeCareSizedBox(height: 16),
          ElevatedButton.icon(
             onPressed: () {},
             icon: const PrimeCareIcon(Icons.rocket_launch_rounded),
             label: const PrimeCareText('DEPLOY STAGING TO PRODUCTION', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
             
          )
        ],
      )
        ),
      ),
    );
  }

  Widget _buildToggle(String title, String desc, bool value, Function(bool) onChanged) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      
      child: SwitchListTile(
        title: PrimeCareText(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: PrimeCarePadding(
          padding: const EdgeInsets.only(top: 8.0),
          child: PrimeCareText(desc, style: const TextStyle(color: PrimeCareColors.slate400, height: 1.4)),
        ),
        value: value,
        activeColor: PrimeCareColors.amber,
        onChanged: onChanged,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
