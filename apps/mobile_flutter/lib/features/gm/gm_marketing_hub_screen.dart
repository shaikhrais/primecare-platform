import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class GmMarketingHubScreen extends StatelessWidget {
  const GmMarketingHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('CLIENT ACQUISITION & BRAND', style: TextStyle(color: PrimeCareColors.purple, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('HOW TO ESTABLISH BRAND', Icons.star_rounded),
          _buildActionCard('Deploy Trust Signals', 'Instantly publish 5-Star verified Medicaid/Medicare Audit badges to all Landing Pages to convert cold traffic into high trust.'),
          _buildActionCard('Automated Review Engine', 'Trigger SMS requests to family members post-shift automatically requesting Google Local Reviews to heavily boost SEO ranking.'),
          
          const PrimeCareSizedBox(height: 32),
          _buildSectionHeader('HOW TO GET NEW CLIENTS (GET BUSY)', Icons.people_alt_rounded),
          _buildActionCard('B2B Hospital discharge API', 'Integrate directly into regional Care-Coordinators systems at hospital discharge desks to catch patient flow before competitors.'),
          _buildActionCard('PPC Hyper-Targeting', 'Deploy "Home Care Near Me" Google Ads algorithmically adjusting bid prices based on current system Nurse availability.'),
          _buildActionCard('Community Penetration', 'Auto-schedule local community center seminars and "Health Fairs" using current off-shift PSWs.'),
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
          PrimeCareIcon(icon, color: PrimeCareColors.purple),
          const PrimeCareSizedBox(width: 8),
          PrimeCareText(title, style: const TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String desc) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimeCareText(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
              const PrimeCareIcon(Icons.arrow_forward_ios_rounded, color: PrimeCareColors.purple, size: 14),
            ],
          ),
          const PrimeCareSizedBox(height: 8),
          PrimeCareText(desc, style: const TextStyle(color: PrimeCareColors.slate400, height: 1.4)),
        ],
      ),
    );
  }
}
