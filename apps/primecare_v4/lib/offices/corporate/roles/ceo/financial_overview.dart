import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';

class FinancialOverviewView extends StatelessWidget {
  const FinancialOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Institutional Financial Performance', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: KpiStatCard(title: 'Annual Revenue', value: '$84.2M', icon: Icons.payments, iconColor: Colors.teal, subtitle: '+18% YoY')),
                const SizedBox(width: 16),
                Expanded(child: KpiStatCard(title: 'Op. Efficiency', value: '92%', icon: Icons.speed, iconColor: Colors.indigo, subtitle: 'Optimized')),
                const SizedBox(width: 16),
                Expanded(child: KpiStatCard(title: 'Regional Growth', value: '+24%', icon: Icons.trending_up, iconColor: Colors.orange, subtitle: 'Ontario/BC Hubs')),
              ],
            ),
            const SizedBox(height: 32),
            const GlassSurface(
              padding: EdgeInsets.all(24),
              child: Text('Executive Summary: Institutional margins remain stable at 24.2%. Strategic focus for Q3: Expansion into Quebec regional hubs.'),
            ),
          ],
        ),
      ),
    );
  }
}
