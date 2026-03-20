import 'package:flutter/material.dart';

class GmExpansionWizardScreen extends StatelessWidget {
  const GmExpansionWizardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('FRANCHISE EXPANSION', style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('HOW TO START A NEW LOCATION', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w900, letterSpacing: 2)),
          const SizedBox(height: 24),
          _buildExpansionStep(1, 'Identify Underserved Zip Codes', 'Run algorithm against Medicare demographics to target aging populations with low PrimeCare Node density.', Icons.map_rounded),
          _buildExpansionStep(2, 'Incorporate Ghost Node', 'Digitally register a new LLC and Cloudflare Tenant DB instantly.', Icons.domain_add_rounded),
          _buildExpansionStep(3, 'Aggressive PSW Recruiting', 'Deploy localized Zip-Recruiter & Indeed API bursts to hire 15+ Core Providers in the target zone.', Icons.people_alt_rounded),
          _buildExpansionStep(4, 'B2B Referral Initialization', 'Auto-Generate marketing packets to local hospitals and Geriatric specialists within 10 miles.', Icons.handshake_rounded),
          _buildExpansionStep(5, 'Launch Geofenced Ad Campaign', 'Allocate \$5k starting budget to Facebook/Google Ads hitting a strict 15-mile radius of the new Node.', Icons.campaign_rounded),
          
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('INITIATE NEW LOCATION LAUNCH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
          )
        ],
      ),
    );
  }

  Widget _buildExpansionStep(int step, String title, String desc, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        border: Border.all(color: const Color(0xFF334155)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Color(0xFF0F172A), shape: BoxShape.circle),
            child: Text('$step', style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: const Color(0xFF3B82F6), size: 18),
                    const SizedBox(width: 8),
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(color: Color(0xFF94A3B8), height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
