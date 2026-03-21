import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';


class GmDashboardScreen extends StatelessWidget {
  const GmDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('Executive Growth Hub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
        backgroundColor: PrimeCareColors.darkMatrix,
        elevation: 0,
        actions: [
          IconButton(icon: const PrimeCareIcon(Icons.business_center_rounded, color: PrimeCareColors.amber), onPressed: () {}),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          return PrimeCareScrollWrapper(
            padding: const EdgeInsets.all(24),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimeCareExpanded(
                  flex: isDesktop ? 1 : 0,
                  child: PrimeCareColumn(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const PrimeCareText('Month-Over-Month Velocity', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      const PrimeCareSizedBox(height: 16),
                      _buildHeroMetric('Net-New Acquisitions', '+41 Patients', '+14.2% MoM', PrimeCareColors.emerald),
                      const PrimeCareSizedBox(height: 16),
                      _buildHeroMetric('EBITDA (Gross Margin)', '32.4%', '+4.1% MoM', PrimeCareColors.amber),
                    ],
                  )
                ),
                if (isDesktop) const PrimeCareSizedBox(width: 32) else const PrimeCareSizedBox(height: 32),
                PrimeCareExpanded(
                  flex: isDesktop ? 1 : 0,
                  child: PrimeCareColumn(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const PrimeCareText('OPERATIONAL LEAKAGE', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      const PrimeCareSizedBox(height: 16),
                      _buildLeakageTile('Surge Pricing Output', '\$14,200', 'Alert: 2x above target', PrimeCareColors.rose),
                      _buildLeakageTile('Overtime Pay (PSW/RN)', '\$3,140', 'Nominal', PrimeCareColors.emerald),
                      const PrimeCareSizedBox(height: 32),
                      PrimeCareButton(type: PrimeCareButtonType.primary, 
                        onPressed: () {},
                        
                        child: const PrimeCareText('GENERATE FRANCHISE REPORT', style: TextStyle(color: PrimeCareColors.amber, fontWeight: FontWeight.bold)),
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
    return PrimeCareCard(
      padding: const EdgeInsets.all(24),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareText(title, style: const TextStyle(color: PrimeCareColors.slate400, fontSize: 14)),
          const PrimeCareSizedBox(height: 8),
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PrimeCareText(mainValue, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1)),
              PrimeCareCard(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                
                child: PrimeCareText(subValue, style: TextStyle(color: trendColor, fontWeight: FontWeight.bold, fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLeakageTile(String title, String amount, String status, Color statusColor) {
    return PrimeCareCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const PrimeCareSizedBox(height: 4),
              PrimeCareText(status, style: TextStyle(color: statusColor, fontSize: 12)),
            ],
          ),
          PrimeCareText(amount, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
