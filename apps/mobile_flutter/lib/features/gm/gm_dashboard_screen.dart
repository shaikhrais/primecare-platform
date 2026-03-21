import 'package:flutter/material.dart';
import '../../core/colors.dart';


class GmDashboardScreen extends StatelessWidget {
  const GmDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: AppBar(
        title: const Text('Executive Growth Hub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.business_center_rounded, color: PrimeCareColors.amber), onPressed: () {}),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Month-Over-Month Velocity', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      const SizedBox(height: 16),
                      _buildHeroMetric('Net-New Acquisitions', '+41 Patients', '+14.2% MoM', PrimeCareColors.emerald),
                      const SizedBox(height: 16),
                      _buildHeroMetric('EBITDA (Gross Margin)', '32.4%', '+4.1% MoM', PrimeCareColors.amber),
                    ],
                  )
                ),
                if (isDesktop) const SizedBox(width: 32) else const SizedBox(height: 32),
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('OPERATIONAL LEAKAGE', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      const SizedBox(height: 16),
                      _buildLeakageTile('Surge Pricing Output', '\$14,200', 'Alert: 2x above target', PrimeCareColors.rose),
                      _buildLeakageTile('Overtime Pay (PSW/RN)', '\$3,140', 'Nominal', PrimeCareColors.emerald),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimeCareColors.slate800,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: PrimeCareColors.slate700)),
                        ),
                        child: const Text('GENERATE FRANCHISE REPORT', style: TextStyle(color: PrimeCareColors.amber, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                )
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildHeroMetric(String title, String mainValue, String subValue, Color trendColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: PrimeCareColors.slate800,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PrimeCareColors.slate700),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: PrimeCareColors.slate400, fontSize: 14)),
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
      decoration: BoxDecoration(color: PrimeCareColors.radarDark, border: Border.all(color: PrimeCareColors.slate800), borderRadius: BorderRadius.circular(12)),
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
