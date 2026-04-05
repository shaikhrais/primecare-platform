import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/audit_log_tile.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class CarePlansView extends ConsumerWidget {
  const CarePlansView({super.key});

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
              // ACTIVE PATIENT LIST
              Text('Active Care Tracks', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildCarePlanCard(
                context,
                'Arthur Dent',
                'Post-Op Recovery (Cardiac)',
                '75%',
                Colors.teal,
                ['Wound Healing', 'Mobilization Tier 2', 'Dietary Sync'],
              ),
              const SizedBox(height: 16),
              _buildCarePlanCard(
                context,
                'Ford Prefect',
                'Chronic Pain Management',
                '40%',
                Colors.orange,
                ['Physiotherapy Lvl 1', 'Medication Adjustment', 'Mental Health Support'],
              ),
              
              const SizedBox(height: 32),

              // RECENT PLAN UPDATES
              Text('Care Navigation Logs', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AuditLogTile(
                      title: 'Goal Achieved: Stage 1 Mobilization', 
                      subtitle: 'Arthur Dent successfully moved 50m with walker.', 
                      timestamp: '2h ago', 
                      icon: Icons.check_circle_outline, 
                      iconColor: Colors.teal
                    ),
                    const Divider(color: Colors.blueGrey, height: 16, thickness: 0.1),
                    AuditLogTile(
                      title: 'Plan Modified: Nutritional Track', 
                      subtitle: 'Ford Prefect diet updated to Low Sodium by Dietitian.', 
                      timestamp: 'Yesterday', 
                      icon: Icons.edit_note, 
                      iconColor: Colors.orange
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),
              
              // GLOBAL ACTIONS
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {}, 
                  icon: const Icon(Icons.add_task),
                  label: const Text('Initiate New Care Track'),
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

  Widget _buildCarePlanCard(BuildContext context, String name, String track, String progress, Color color, List<String> goals) {
    return GlassSurface(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.1),
                child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(track, style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(progress, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
                  const Text('COMPLETION', style: TextStyle(color: Colors.blueGrey, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: double.parse(progress.replaceAll('%', '')) / 100.0,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 24),
          const Text('Top Priority Goals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: goals.map((goal) => Chip(
              label: Text(goal, style: const TextStyle(fontSize: 11)),
              backgroundColor: Colors.white.withValues(alpha: 0.5),
              side: BorderSide(color: Colors.blueGrey.withValues(alpha: 0.1)),
              padding: EdgeInsets.zero,
            )).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              TextButton(key: const Key('data-status-id=clinic-rn-care-action-1'), 
                onPressed: () {}, 
                child: const Text('View Full History', style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(key: const Key('data-status-id=clinic-rn-care-action-2'), 
                onPressed: () {}, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
                  foregroundColor: AppTheme.primary,
                  elevation: 0,
                ),
                child: const Text('Modify Plan', style: TextStyle(fontSize: 13)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
