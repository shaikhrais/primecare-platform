import 'package:flutter/material.dart';

class GmDashboardScreen extends StatelessWidget {
  const GmDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Executive Growth Hub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
        backgroundColor: const Color(0xFF020617),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.business_center_rounded, color: Color(0xFFF59E0B)), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Month-Over-Month Velocity', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 16),
            _buildHeroMetric('Net-New Acquisitions', '+41 Patients', '+14.2% MoM', const Color(0xFF10B981)),
            const SizedBox(height: 16),
            _buildHeroMetric('EBITDA (Gross Margin)', '32.4%', '+4.1% MoM', const Color(0xFFF59E0B)),
            const SizedBox(height: 32),
            
            const Text('OPERATIONAL LEAKAGE', style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 16),
            _buildLeakageTile('Surge Pricing Output', '\$14,200', 'Alert: 2x above target', const Color(0xFFE11D48)),
            _buildLeakageTile('Overtime Pay (PSW/RN)', '\$3,140', 'Nominal', const Color(0xFF10B981)),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFF334155))),
              ),
              child: const Text('GENERATE FRANCHISE REPORT', style: TextStyle(color: Color(0xFFF59E0B), fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeroMetric(String title, String mainValue, String subValue, Color trendColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(mainValue, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: trendColor.withAlpha(20), borderRadius: BorderRadius.circular(8)),
                child: Text(subValue, style: TextStyle(color: trendColor, fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLeakageTile(String title, String amount, String status, Color statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF0F172A), border: Border.all(color: const Color(0xFF1E293B)), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(status, style: TextStyle(color: statusColor, fontSize: 12)),
            ],
          ),
          Text(amount, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
