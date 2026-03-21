import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class GmCostReductionScreen extends StatelessWidget {
  const GmCostReductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('REVENUE & COST ARCHITECTURE', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('BUILDING RECURRING INCOME', Icons.autorenew_rounded),
          _buildTacticalTile('Subscription Retainers', 'Convert pure hourly billing into monthly "Concierge Retainers" guaranteeing baseline recurring revenue regardless of weekly shift output.'),
          _buildTacticalTile('Medicaid Volume Billing', 'Establish programmatic batch-billing to Medicaid clearing houses instantly reducing Days Sales Outstanding (DSO) from 45 to 7 days.'),
          
          const PrimeCareSizedBox(height: 32),
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
    return PrimeCarePadding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PrimeCareRow(
        children: [
          PrimeCareIcon(icon, color: PrimeCareColors.emerald),
          const PrimeCareSizedBox(width: 8),
          PrimeCareExpanded(child: PrimeCareText(title, style: const TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.w900, letterSpacing: 1.5))),
        ],
      ),
    );
  }

  Widget _buildTacticalTile(String title, String desc) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareText(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
          const PrimeCareSizedBox(height: 8),
          PrimeCareText(desc, style: const TextStyle(color: PrimeCareColors.slate400, height: 1.4)),
        ],
      ),
    );
  }
}
