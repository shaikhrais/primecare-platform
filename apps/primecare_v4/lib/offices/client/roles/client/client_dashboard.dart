import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({Key? key}) : super(key: key);

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
            Text('Hello, Arthur Dent', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit', color: AppTheme.primary)),
            const Text('Your health and wellness overview for today.', style: TextStyle(color: Colors.blueGrey)),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: KpiStatCard(title: 'Wellness Score', value: '92', icon: Icons.favorite, iconColor: Colors.red, subtitle: 'Optimal Range')),
                const SizedBox(width: 16),
                Expanded(child: KpiStatCard(title: 'Next Visit', value: '02:00 PM', icon: Icons.event, iconColor: Colors.teal, subtitle: 'RN Arthur Dent')),
                const SizedBox(width: 16),
                Expanded(child: KpiStatCard(title: 'Alerts', value: '0', icon: Icons.notifications_none, iconColor: Colors.blueGrey, subtitle: 'Status: Clear')),
              ],
            ),
            const SizedBox(height: 32),
            Text('Upcoming Care Schedule', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 16),
            const GlassSurface(
              padding: EdgeInsets.all(24),
              child: Text('You have 2 clinical visits scheduled for the next 24 hours. Your care team is fully synced.'),
            ),
          ],
        ),
      ),
    );
  }
}
