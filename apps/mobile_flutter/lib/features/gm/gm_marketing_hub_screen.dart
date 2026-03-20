import 'package:flutter/material.dart';

class GmMarketingHubScreen extends StatelessWidget {
  const GmMarketingHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('CLIENT ACQUISITION & BRAND', style: TextStyle(color: Color(0xFF8B5CF6), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('HOW TO ESTABLISH BRAND', Icons.star_rounded),
          _buildActionCard('Deploy Trust Signals', 'Instantly publish 5-Star verified Medicaid/Medicare Audit badges to all Landing Pages to convert cold traffic into high trust.'),
          _buildActionCard('Automated Review Engine', 'Trigger SMS requests to family members post-shift automatically requesting Google Local Reviews to heavily boost SEO ranking.'),
          
          const SizedBox(height: 32),
          _buildSectionHeader('HOW TO GET NEW CLIENTS (GET BUSY)', Icons.people_alt_rounded),
          _buildActionCard('B2B Hospital discharge API', 'Integrate directly into regional Care-Coordinators systems at hospital discharge desks to catch patient flow before competitors.'),
          _buildActionCard('PPC Hyper-Targeting', 'Deploy "Home Care Near Me" Google Ads algorithmically adjusting bid prices based on current system Nurse availability.'),
          _buildActionCard('Community Penetration', 'Auto-schedule local community center seminars and "Health Fairs" using current off-shift PSWs.'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF8B5CF6)),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w900, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        border: Border.all(color: const Color(0xFF4C1D95)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
              const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF8B5CF6), size: 14),
            ],
          ),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(color: Color(0xFF94A3B8), height: 1.4)),
        ],
      ),
    );
  }
}
