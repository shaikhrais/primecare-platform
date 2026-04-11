import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:flutter_ui/src/components/primecare_stat_card.dart';
import 'package:flutter_ui/src/components/page_template.dart';

class ScrumMasterDashboardScreen extends ConsumerWidget {
  const ScrumMasterDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(scrumMasterDashboardAdapterProvider);

    return PageTemplate(
      title: 'scrum_master Dashboard',
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
        data: (ScrumMasterDashboardViewModel liveData) {
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
    if (t.contains('user') || t.contains('client')) return LucideIcons.users;
    if (t.contains('report')) return LucideIcons.fileText;
    if (t.contains('score')) return LucideIcons.award;
    if (t.contains('alert') || t.contains('pending'))
      return LucideIcons.alertCircle;
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
