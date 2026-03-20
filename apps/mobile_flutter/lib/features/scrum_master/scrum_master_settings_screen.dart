import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('SCM_GLOBAL_CONFIG', style: TextStyle(color: Color(0xFFF59E0B), fontFamily: 'monospace', fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('ENVIRONMENT OVERRIDES', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, letterSpacing: 2)),
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
          const Text('ADMIN ACTIONS', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
             onPressed: () {},
             icon: const Icon(Icons.rocket_launch_rounded),
             label: const Text('DEPLOY STAGING TO PRODUCTION', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
             style: ElevatedButton.styleFrom(
               backgroundColor: const Color(0xFF10B981),
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
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(desc, style: const TextStyle(color: Color(0xFF94A3B8), height: 1.4)),
        ),
        value: value,
        activeColor: const Color(0xFFF59E0B),
        onChanged: onChanged,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
