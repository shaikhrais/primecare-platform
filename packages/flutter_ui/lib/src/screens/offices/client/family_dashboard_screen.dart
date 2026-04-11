import 'package:flutter_ui/src/components/page_template.dart';
import 'package:flutter_ui/src/components/primecare_stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';

class FamilyDashboardScreen extends ConsumerWidget {
  const FamilyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(
      dashboardMetricsProvider('familyDashboardScreen'),
    );

    return PageTemplate(
      title: 'Family Dashboard',
      subtitle: 'Real-time overview fetched natively via API.',
      kpiCards: metricsAsyncValue.when(
        loading: () => [
          const Center(
            child: CircularProgressIndicator(color: Colors.tealAccent),
          ),
        ],
        error: (error, stackTrace) => [
          Container(
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
                    'Failed to load live metrics: \n$error',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
        data: (DashboardMetrics liveData) {
          return liveData.kpis.map((kpi) {
            return PrimeCareStatCard(
              title: kpi.title,
              value: kpi.value,
              deltaSuffix: kpi.trend,
              icon: _inferIcon(kpi.title),
              iconColor: _inferColor(kpi.status),
            );
          }).toList();
        },
      ),
      bodySections: const [
        // Advanced components (Charts, Maps, Grids) go here based on role
      ],
    );
  }

  IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice'))
      return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule'))
      return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical'))
      return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn'))
      return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline'))
      return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  Color _inferColor(String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up')
      return Colors.greenAccent;
    if (s == 'warning' || s == 'attention') return Colors.orangeAccent;
    if (s == 'critical' || s == 'down' || s == 'negative')
      return Colors.redAccent;
    return Colors.tealAccent;
  }
}
