import 'package:flutter/material.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';

class GmCostReductionScreen extends StatelessWidget {
  const GmCostReductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('REVENUE & COST ARCHITECTURE', style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('BUILDING RECURRING INCOME', Icons.autorenew_rounded),
          _buildTacticalTile('Subscription Retainers', 'Convert pure hourly billing into monthly "Concierge Retainers" guaranteeing baseline recurring revenue regardless of weekly shift output.'),
          _buildTacticalTile('Medicaid Volume Billing', 'Establish programmatic batch-billing to Medicaid clearing houses instantly reducing Days Sales Outstanding (DSO) from 45 to 7 days.'),
          
          const SizedBox(height: 32),
          _buildSectionHeader('REDUCING OPERATING COSTS & EXPENSES', Icons.trending_down_rounded),
          _buildTacticalTile('AI Geospatial Routing', 'Enforce the Jane App Grid scheduler with LatLong checks, physically preventing PSWs from driving >10 miles between shifts, destroying fuel and travel-time waste.'),
          _buildTacticalTile('Strict Surge-Locking', 'Automatically deny dispatchers the right to offer 2x Surge pricing unless the shift gross margin remains above physically configured EBITDA floors.'),
          _buildTacticalTile('Automated EVV Verification', 'Eliminate manual timesheet auditing. Only approve payroll if Cloudflare GPS arrays verify physical phone presence within 50ft of the patient residence.'),
        ],
      )
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF10B981)),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w900, letterSpacing: 1.5))),
        ],
      ),
    );
  }

  Widget _buildTacticalTile(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        border: Border.all(color: const Color(0xFF047857)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(color: Color(0xFF94A3B8), height: 1.4)),
        ],
      ),
    );
  }
}
