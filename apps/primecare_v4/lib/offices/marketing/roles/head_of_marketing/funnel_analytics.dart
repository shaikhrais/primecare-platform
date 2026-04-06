import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_v4/design_system/clinical_glass.dart';
import 'package:primecare_v4/design_system/primecare_theme.dart';

class FunnelAnalyticsScreen extends ConsumerWidget {
  const FunnelAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Funnel Analytics',
              style: PrimeCareTheme.typography.heroTitle.copyWith(
                color: PrimeCareTheme.colors.navyIndigo,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Breakdown of the patient acquisition funnel: Impressions -> Clicks -> Leads.',
              style: PrimeCareTheme.typography.body.copyWith(
                color: PrimeCareTheme.colors.slateGray,
              ),
            ),
            const SizedBox(height: 32),
            ClinicalGlassPanel(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Global Funnel Performance', style: PrimeCareTheme.typography.h2),
                  const SizedBox(height: 32),
                  _buildFunnelStage('Impressions', '1,250,400', '100%', PrimeCareTheme.colors.surfaceContainerHighest, 1.0),
                  _buildConnectingArrow('2.4% CTR'),
                  _buildFunnelStage('Clicks', '30,009', '2.4%', PrimeCareTheme.colors.emeraldTeal.withOpacity(0.2), 0.8),
                  _buildConnectingArrow('12% CVR'),
                  _buildFunnelStage('Leads Generated (MQLs)', '3,601', '0.28%', PrimeCareTheme.colors.emeraldTeal.withOpacity(0.5), 0.6),
                  _buildConnectingArrow('45% Qualification Rate'),
                  _buildFunnelStage('Consultations Booked (SQLs)', '1,620', '0.12%', PrimeCareTheme.colors.emeraldTeal.withOpacity(0.8), 0.4),
                  _buildConnectingArrow('82% Show Rate'),
                  _buildFunnelStage('New Patients', '1,328', '0.10%', PrimeCareTheme.colors.navyIndigo, 0.25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFunnelStage(String title, String value, String initialPct, Color color, double widthRatio) {
    return FractionallySizedBox(
      widthFactor: widthRatio,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: PrimeCareTheme.typography.h3.copyWith(color: widthRatio < 0.4 ? Colors.white : PrimeCareTheme.colors.navyIndigo)),
            Row(
              children: [
                Text(initialPct, style: PrimeCareTheme.typography.label.copyWith(color: widthRatio < 0.4 ? Colors.white70 : PrimeCareTheme.colors.slateGray)),
                const SizedBox(width: 16),
                Text(value, style: PrimeCareTheme.typography.h2.copyWith(color: widthRatio < 0.4 ? Colors.white : PrimeCareTheme.colors.navyIndigo)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildConnectingArrow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Icon(LucideIcons.arrowDown, color: PrimeCareTheme.colors.slateGray, size: 20),
          Text(text, style: PrimeCareTheme.typography.label.copyWith(color: PrimeCareTheme.colors.coralRed)),
        ],
      )
    );
  }
}
