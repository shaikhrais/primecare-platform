import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/src/components/layouts/provider_layout.dart';
import 'package:flutter_ui/src/components/primecare_stat_card.dart';

class QaDashboardScreen extends ConsumerWidget {
  const QaDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(qaDashboardAdapterProvider);

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qa Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time overview fetched natively via API.',
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
              error: (error, stackTrace) => Container(
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
                        'Failed to load live metrics for Qa: \n$error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              data: (QaDashboardViewModel liveData) {
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
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('user') || t.contains('client')) return LucideIcons.users;
    if (t.contains('report')) return LucideIcons.fileText;
    if (t.contains('score')) return LucideIcons.award;
    if (t.contains('alert') || t.contains('pending')) return LucideIcons.alertCircle;
    return LucideIcons.activity;
  }

  Color _inferColor(String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up') return Colors.greenAccent;
    if (s == 'warning' || s == 'attention') return Colors.orangeAccent;
    if (s == 'critical' || s == 'down' || s == 'negative') return Colors.redAccent;
    return Colors.tealAccent;
  }
}
