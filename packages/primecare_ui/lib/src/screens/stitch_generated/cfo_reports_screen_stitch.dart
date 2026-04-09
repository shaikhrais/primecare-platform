import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:primecare_core/dashboard_service.dart';
import 'package:primecare_core/dashboard_providers.dart';
// Use local imports if they are in same package, or core if they are exported there. We assume primecare_ui components.
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/components/layouts/provider_layout.dart';

class CfoReportsScreenStitch extends ConsumerWidget {
  const CfoReportsScreenStitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(dashboardMetricsProvider('CfoReportsScreenStitch'));

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CfoReportsScreen',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Stitch-generated Physical Screen.',
              style: TextStyle(color: Colors.white.withAlpha(178), fontSize: 16),
            ),
            const SizedBox(height: 32),
            
            metricsAsyncValue.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(64.0),
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                ),
              ),
              error: (error, _) => _buildErrorState(error.toString()),
              data: (DashboardMetrics liveData) => _buildDataState(context, liveData),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.redAccent.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withAlpha(76)),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.alertTriangle, color: Colors.redAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Failed to load metrics for CfoReportsScreenStitch: \n$error',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataState(BuildContext context, DashboardMetrics liveData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: liveData.kpis.map((kpi) {
            return PrimeCareStatCard(
              title: kpi.title,
              value: kpi.value,
              deltaSuffix: kpi.trend,
              icon: _inferIcon(kpi.title),
              iconColor: _inferColor(kpi.status),
            );
          }).toList(),
        ),
        const SizedBox(height: 40),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withAlpha(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Operations Feed',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 24),
                    if (liveData.recentActivity.isEmpty)
                      const Center(
                        child: Text(
                          'No recent activity reported',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ...liveData.recentActivity.map((activity) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(LucideIcons.activity, color: Colors.tealAccent, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity.title,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    activity.subtitle,
                                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              activity.timestamp,
                              style: const TextStyle(color: Colors.white38, fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.tealAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.tealAccent.withAlpha(76)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Status',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.tealAccent,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 24),
                    _buildStatusRow(LucideIcons.server, 'Core API URL', 'Connected', Colors.greenAccent),
                    const SizedBox(height: 16),
                    _buildStatusRow(LucideIcons.database, 'Data Lake', 'Operational', Colors.greenAccent),
                    const SizedBox(height: 16),
                    _buildStatusRow(LucideIcons.shieldCheck, 'Live Sync', 'Active', Colors.blueAccent),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice')) return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule')) return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical')) return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn')) return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline')) return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  Color _inferColor(String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up') return Colors.greenAccent;
    if (s == 'warning' || s == 'attention') return Colors.orangeAccent;
    if (s == 'critical' || s == 'down' || s == 'negative') return Colors.redAccent;
    return Colors.tealAccent;
  }

  Widget _buildStatusRow(IconData icon, String label, String status, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(51),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
