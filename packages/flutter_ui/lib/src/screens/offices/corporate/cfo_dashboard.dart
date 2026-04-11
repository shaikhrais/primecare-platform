import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/src/components/layouts/provider_layout.dart';
import 'package:flutter_ui/src/components/primecare_stat_card.dart';
import '../../../widgets/primecare_line_chart.dart';
import '../../../widgets/primecare_pie_chart.dart';
import '../../../widgets/primecare_gauge_chart.dart';

class CfoDashboard extends ConsumerWidget {
  const CfoDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(cfoDashboardDataProvider('main'));

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cfo Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time overview fetched natively via API.',
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
                        'Failed to load live metrics for cfoDashboard: \n$error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              data: (CfoDashboardViewModel liveData) {
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
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: PrimeCareLineChart(
                            title: 'Historical Revenue (\$M)',
                            data: liveData.revenueData,
                            labels: liveData.revenueLabels,
                            height: 300,
                            lineColor: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              PrimeCarePieChart(
                                title: 'Expense Breakdown',
                                data: _buildPieData(liveData),
                                height: 200,
                              ),
                              const SizedBox(height: 24),
                              PrimeCareGaugeChart(
                                title: 'EBITDA Target',
                                subtitle: 'QTD performance vs goal',
                                value: liveData.ebitdaTargetMax > 0
                                    ? (liveData.ebitdaTargetValue /
                                              liveData.ebitdaTargetMax) *
                                          100.0
                                    : 0,
                                height: 200,
                                activeColor: Colors.greenAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
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

  List<PrimeCarePieChartData> _buildPieData(CfoDashboardViewModel liveData) {
    if (liveData.expenseData.isEmpty ||
        liveData.expenseLabels.length != liveData.expenseData.length)
      return [];

    final colors = [
      Colors.blueAccent,
      Colors.indigoAccent,
      Colors.tealAccent,
      Colors.cyanAccent,
      Colors.deepPurpleAccent,
      Colors.lightBlueAccent,
    ];

    return List.generate(liveData.expenseData.length, (index) {
      return PrimeCarePieChartData(
        label: liveData.expenseLabels[index],
        value: liveData.expenseData[index],
        color: colors[index % colors.length],
      );
    });
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
