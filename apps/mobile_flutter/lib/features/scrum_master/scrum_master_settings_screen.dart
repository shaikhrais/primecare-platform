import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';

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
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: AppBar(
        title: const Text('SCM_GLOBAL_CONFIG', style: TextStyle(color: PrimeCareColors.amber, fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('ENVIRONMENT OVERRIDES', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 16),
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

          const SizedBox(height: 48),
          const Text('ADMIN ACTIONS', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
             onPressed: () {},
             icon: const Icon(Icons.rocket_launch_rounded),
             label: const Text('DEPLOY STAGING TO PRODUCTION', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
             style: ElevatedButton.styleFrom(
               backgroundColor: PrimeCareColors.emerald,
               foregroundColor: Colors.white,
               padding: const EdgeInsets.all(20),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
             ),
          )
        ],
      )
        ),
      ),
    );
  }

  Widget _buildToggle(String title, String desc, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate800,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PrimeCareColors.slate700),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(desc, style: const TextStyle(color: PrimeCareColors.slate400, height: 1.4)),
        ),
        value: value,
        activeColor: PrimeCareColors.amber,
        onChanged: onChanged,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
