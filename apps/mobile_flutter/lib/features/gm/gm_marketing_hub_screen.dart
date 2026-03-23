import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class GmMarketingHubScreen extends StatelessWidget {
  const GmMarketingHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareListView(
        padding: EdgeInsets.all(24),
        children: [
          _buildSectionHeader('HOW TO ESTABLISH BRAND', Icons.star_rounded),
          _buildActionCard('Deploy Trust Signals', 'Instantly publish 5-Star verified Medicaid/Medicare Audit badges to all Landing Pages to convert cold traffic into high trust.'),
          _buildActionCard('Automated Review Engine', 'Trigger SMS requests to family members post-shift automatically requesting Google Local Reviews to heavily boost SEO ranking.'),
          
          SizedBox(height: 32),
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
      padding: EdgeInsets.only(bottom: 16),
      child: PrimeCareRow(
        children: [
          PrimeCareIcon(icon, color: PrimeCareColors.purple),
          SizedBox(width: 8),
          PrimeCareText(title, style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String desc) {
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimeCareText(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
              PrimeCareIcon(Icons.arrow_forward_ios_rounded, color: PrimeCareColors.purple, size: 14),
            ],
          ),
          SizedBox(height: 8),
          PrimeCareText(desc, style: TextStyle(color: PrimeCareColors.slate400, height: 1.4)),
        ],
      ),
    );
  }
}
