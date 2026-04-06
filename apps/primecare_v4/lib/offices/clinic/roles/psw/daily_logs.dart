import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class DailyLogsScreen extends ConsumerWidget {
  const DailyLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DAILY SUMMARY HUD
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Tasks Done', value: '14/15', icon: Icons.task_alt, iconColor: Colors.teal, subtitle: '92% Completed')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Meal Intake', value: 'Average', icon: Icons.restaurant, iconColor: Colors.orange, subtitle: 'Last: Breakfast')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Hydration', value: '1.2L', icon: Icons.water_drop, iconColor: Colors.blue, subtitle: 'Goal: 2L')),
                ],
              ),

              const SizedBox(height: 32),

              // ADL CHECKLIST
              Text('Activities of Daily Living (ADL)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildAdlItem('Morning Grooming & Hygiene', true),
              _buildAdlItem('Assisted Mobilization (50m)', true),
              _buildAdlItem('Medication Supervision', true),
              _buildAdlItem('Evening Meal Prep', false),

              const SizedBox(height: 32),

              // MEAL INTAKE SLIDERS
              Text('Nutritional Intake Verification', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildIntakeSlider('Breakfast Intake', 0.8),
                    const SizedBox(height: 24),
                    _buildIntakeSlider('Lunch Intake', 0.5),
                    const SizedBox(height: 24),
                    _buildIntakeSlider('Water Intake (Glasses)', 0.6),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              
              // ACTIONS
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save),
                  label: const Text('Finalize Shift Logs'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildAdlItem(String label, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GlassSurface(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Icon(done ? Icons.check_circle : Icons.circle_outlined, color: done ? Colors.teal : Colors.blueGrey, size: 20),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: done ? Colors.black : Colors.blueGrey))),
          ],
        ),
      ),
    );
  }

  Widget _buildIntakeSlider(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${(value * 100).toInt()}%', style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: value,
          backgroundColor: AppTheme.primary.withValues(alpha: 0.05),
          valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
