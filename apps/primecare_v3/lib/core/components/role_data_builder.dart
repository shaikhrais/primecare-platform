import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../providers/role_hydration_provider.dart';
import '../data/role_data_model.dart';

class RoleDataBuilder extends ConsumerWidget {
  final String roleId;
  final Widget Function(BuildContext context, RoleDataModel data) builder;

  const RoleDataBuilder({
    super.key,
    required this.roleId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(roleHydrationProvider(roleId));

    return asyncData.when(
      data: (data) => builder(context, data),
      loading: () => Padding(
        padding: const EdgeInsets.all(48),
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF0F172A)),
        ),
      ),
      error: (err, stack) => UrgentAlertBanner(
        message: 'Hydration Exception: \$err',
      ),
    );
  }
}

class DashboardKpiGrid extends StatelessWidget {
  final List<KpiMetric> kpis;
  final String title;

  const DashboardKpiGrid({
    super.key,
    required this.kpis,
    this.title = 'Operations Tracker',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimeCareText(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const PrimeCareSizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
              ),
              itemCount: kpis.length,
              itemBuilder: (context, index) {
                final kpi = kpis[index];
                return PrimeCareCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      if (kpi.icon != null) ...[
                        CircleAvatar(
                          backgroundColor: const Color(0xFF0F172A).withOpacity(0.1),
                          child: Icon(kpi.icon, color: const Color(0xFF0F172A)),
                        ),
                        const PrimeCareSizedBox(width: 16),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimeCareText(kpi.label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            PrimeCareText(kpi.value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      if (kpi.trend != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: kpi.isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: PrimeCareText(
                            kpi.trend!,
                            style: TextStyle(
                              color: kpi.isPositive ? Colors.green : Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
