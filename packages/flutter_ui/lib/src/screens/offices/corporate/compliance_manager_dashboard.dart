import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_ui/src/components/layouts/provider_layout.dart';
import 'package:flutter_ui/src/components/primecare_stat_card.dart';
import 'package:flutter_ui/src/components/fallback_state_wrapper.dart';

class ComplianceManagerDashboard extends ConsumerWidget {
  const ComplianceManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(
      complianceManagerDashboardDataProvider('main'),
    );

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'corporate.complianceManager.dashboard.title'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'corporate.complianceManager.dashboard.subtitle'.tr(),
              style: TextStyle(
                color: Colors.white.withAlpha(178),
                fontSize: 16,
              ),
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
                    const Icon(
                      LucideIcons.alertTriangle,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Failed to load live metrics for Compliance Manager: \n$error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              data: (ComplianceManagerDashboardViewModel liveData) {
                return FallbackStateWrapper(
                  isOfflineFallback: liveData.isOfflineFallback,
                  child: Column(
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
                        ),
                );
              }).toList(),
                    ),
                    if (liveData.recentActivity.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      Text(
                        'Recent Activity',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: liveData.recentActivity.length,
                        separatorBuilder: (context, index) =>
                            const Divider(color: Colors.white24),
                        itemBuilder: (context, index) {
                          final activity = liveData.recentActivity[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.tealAccent.withAlpha(25),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                LucideIcons.activity,
                                color: Colors.tealAccent,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              activity.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              activity.subtitle,
                              style: TextStyle(
                                color: Colors.white.withAlpha(178),
                              ),
                            ),
                            trailing: Text(
                              activity.timestamp,
                              style: TextStyle(
                                color: Colors.white.withAlpha(128),
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
    if (t.contains('incident') ||
        t.contains('policy') ||
        t.contains('violation'))
      return LucideIcons.shieldAlert;
    if (t.contains('audit') || t.contains('pass'))
      return LucideIcons.checkSquare;
    if (t.contains('renewal')) return LucideIcons.refreshCcw;
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
