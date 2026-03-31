import 'package:flutter/material.dart';
import '../layouts/master_layout.dart';
import '../../core/theme/app_theme.dart';
import '../components/gradient_button.dart';
import '../components/health_indicator.dart';

class PswDashboardScreen extends StatelessWidget {
  const PswDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(48.0), // spacing-12
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clinical Overview', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 32),
            
            // Asymmetric Layout: Left Col (Large), Right Col (Stacked Smalls)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: AppTheme.ambientShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Patient Adherence Score', style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(height: 48), // spacing-12 separating title from content
                        Text('94%', style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppTheme.primary)),
                        const SizedBox(height: 16),
                        const HealthIndicator(progress: 0.94),
                        const SizedBox(height: 16),
                        const Text('Top tier clinical performance this week. Keep maintaining thorough visit summaries.'),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 48), // Large breathing room
                
                // Two smaller vertical action cards
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: AppTheme.ambientShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pending Summaries', style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(height: 16),
                            const Text('3 charts require signature.'),
                            const SizedBox(height: 32),
                            GradientButton(text: 'Review Now', onPressed: () {}),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: AppTheme.ambientShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Upcoming Visits', style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(height: 16),
                            const Text('Your next client is at 10:30 AM.'),
                            const SizedBox(height: 32),
                            GradientButton(text: 'View Schedule', onPressed: () {}, isSecondary: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

