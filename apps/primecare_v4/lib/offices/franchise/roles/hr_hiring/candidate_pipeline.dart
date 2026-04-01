import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class CandidatePipelineView extends ConsumerWidget {
  const CandidatePipelineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Strategic HR Pipeline',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Outfit',
            color: AppTheme.primary,
          ),
        ),
      ),
      body: metricsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HR HUD
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'Active Pipeline', value: '142', icon: Icons.people_outline, iconColor: Colors.indigo, subtitle: '8 High Priority')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Pending Offer', value: '12', icon: Icons.verified_user_outlined, iconColor: Colors.teal, subtitle: 'Final Review')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Time-to-Hire', value: '14d', icon: Icons.timer_outlined, iconColor: Colors.orange, subtitle: 'Optimization: Good')),
                ],
              ),

              const SizedBox(height: 32),

              // PIPELINE STAGES
              Text('Clinical Recruitment Stages', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildCandidateRow('Zane Beeblebrox', 'Role: Registered Nurse', 'SCREENING', Colors.blue),
              _buildCandidateRow('Marvin Robot', 'Role: Physiotherapist', 'INTERVIEW', Colors.orange),
              _buildCandidateRow('Slartibartfast', 'Role: PSW Lead', 'OFFER SENT', Colors.teal),

              const SizedBox(height: 32),

              // ACTION TOOLS
              Text('Talent Acquisition Toolbox', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildToolItem('Post New clinical Opportunity', Icons.add_business_outlined),
                    const Divider(height: 32, thickness: 0.1),
                    _buildToolItem('Bulk Resume Review (AI Powered)', Icons.auto_awesome_outlined),
                    const Divider(height: 32, thickness: 0.1),
                    _buildToolItem('Background Check Integration', Icons.security_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCandidateRow(String name, String role, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(radius: 18, backgroundColor: color.withOpacity(0.1), child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold))),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(role, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolItem(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primary),
        const SizedBox(width: 16),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        const Icon(Icons.chevron_right, color: Colors.blueGrey, size: 16),
      ],
    );
  }
}
