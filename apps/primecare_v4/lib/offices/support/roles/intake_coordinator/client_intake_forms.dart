import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../office/components/kpi_stat_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../providers/dashboard_providers.dart';

class ClientIntakeFormsView extends ConsumerWidget {
  const ClientIntakeFormsView({Key? key}) : super(key: key);

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
          'Patient Intake Digitization',
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
              // INTAKE HUD
              Row(
                children: [
                  Expanded(child: KpiStatCard(title: 'New Intakes', value: '42', icon: Icons.person_add, iconColor: Colors.teal, subtitle: 'Last 7 Days')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Pending Verify', value: '8', icon: Icons.fact_check, iconColor: Colors.orange, subtitle: 'RN Review Needed')),
                  const SizedBox(width: 16),
                  Expanded(child: KpiStatCard(title: 'Avg. Cycle Time', value: '1.4d', icon: Icons.timer_outlined, iconColor: Colors.indigo, subtitle: 'Goal: 1.0d')),
                ],
              ),

              const SizedBox(height: 32),

              // ACTIVE INTAKE TRIAGE
              Text('In-Progress Intake Pipeline', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              _buildIntakeRow('Arthur Dent', 'Stage: RN Assessment', '75%', Colors.teal),
              _buildIntakeRow('Ford Prefect', 'Stage: Document Upload', '40%', Colors.orange),
              _buildIntakeRow('Tricia McMillan', 'Stage: Financial Verify', '90%', Colors.teal),

              const SizedBox(height: 32),

              // QUICK TOOLS
              Text('Intake Specialist Toolbox', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
              const SizedBox(height: 16),
              GlassSurface(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildToolItem('Initiate New Patient Intake', Icons.add_circle_outline),
                    const Divider(height: 32, thickness: 0.1),
                    _buildToolItem('Bulk Document OCR Upload', Icons.document_scanner_outlined),
                    const Divider(height: 32, thickness: 0.1),
                    _buildToolItem('Regional Eligibility Calculator', Icons.calculate_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntakeRow(String patient, String stage, String progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassSurface(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(radius: 18, backgroundColor: color.withOpacity(0.1), child: Text(patient[0], style: TextStyle(color: color, fontWeight: FontWeight.bold))),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(patient, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(stage, style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                ],
              ),
            ),
            Text(progress, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
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
