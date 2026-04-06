import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class EnterpriseOverviewScreen extends ConsumerWidget {
  const EnterpriseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enterprise Overview',
                      style: PrimeCareTheme.typography.heroTitle.copyWith(
                        color: PrimeCareTheme.colors.navyIndigo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Global health of the PrimeCare platform across all networks.',
                      style: PrimeCareTheme.typography.body.copyWith(
                        color: PrimeCareTheme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
                ClinicalGlassButton(
                  onPressed: () {},
                  icon: LucideIcons.download,
                  label: 'Executive Brief',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Total Revenue (YTD)', '\$145.2M', '+18.4% YoY', LucideIcons.dollarSign)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Active Franchises', '42', '+5 this month', LucideIcons.building)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Patients Served', '1.2M', '+120k YoY', LucideIcons.users)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Compliance Score', '99.4%', 'Excellent', LucideIcons.shieldCheck)),
              ],
            ),
            const SizedBox(height: 24),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Enterprise Growth Footprint', style: PrimeCareTheme.typography.h2),
                      Row(
                        children: [
                          Icon(LucideIcons.globe, color: PrimeCareTheme.colors.slateGray, size: 20),
                          const SizedBox(width: 8),
                          Text('Global Map View', style: PrimeCareTheme.typography.label),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: PrimeCareTheme.colors.surfaceContainerHighest.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.map, size: 64, color: PrimeCareTheme.colors.navyIndigo.withOpacity(0.3)),
                          const SizedBox(height: 16),
                          Text('Geospatial Data Loading...', style: PrimeCareTheme.typography.body.copyWith(color: PrimeCareTheme.colors.slateGray)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon) {
    return ClinicalGlassPanel(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.slateGray)),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PrimeCareTheme.colors.emeraldTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: PrimeCareTheme.colors.emeraldTeal, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(value, style: PrimeCareTheme.typography.heroTitle),
          const SizedBox(height: 4),
          Text(subtitle, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.emeraldTeal)),
        ],
      ),
    );
  }
}
