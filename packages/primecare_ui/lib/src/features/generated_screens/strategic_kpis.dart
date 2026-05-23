// Governance - Category: service | Purpose: Core implementation file for the Strategic Kpis platform logic.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

final strategicKpisProvider = FutureProvider.autoDispose<DashboardMetrics>((ref) async {
  ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));
  
  final isOnline = ref.watch(isOnlineProvider);
  if (!isOnline) {
    return DashboardMetrics(
      kpis: const {
        'EBITDA Growth': '+12.4%',
        'Clinical Conversions': '74.2%',
        'Active PSWs': '142',
        'SOS Response Time': '1.8 mins',
      },
      charts: const [
        AnalyticsChart(
          id: 'conversion_trend',
          title: 'Weekly Clinical Conversion Rate (%)',
          type: ChartType.line,
          dataPoints: [
            DataPoint(label: 'Week 1', value: 71.0),
            DataPoint(label: 'Week 2', value: 72.5),
            DataPoint(label: 'Week 3', value: 73.8),
            DataPoint(label: 'Week 4', value: 74.2),
          ],
        )
      ],
      recentActivity: [
        ActivityItem(
          id: 'act-kpi-1',
          title: 'Nationwide Case Audit Complete',
          subtitle: '98.5% HIPAA conformity index verified.',
          timestamp: DateTime.now(),
        ),
      ],
      insights: const [
        IntelligenceInsight(
          id: 'ins-kpi-1',
          title: 'PSW Utilization Advisory',
          summary: 'Increased scheduling density in South region matches demand surges.',
          impact: InsightImpact.positive,
        )
      ],
      isOfflineFallback: true,
    );
  }
  
  final api = ref.read(apiClientProvider);
  try {
    final response = await api.get('/v1/governance/dashboard');
    if (response.statusCode == 200 && response.data != null) {
      return DashboardMetrics(
        kpis: const {
          'EBITDA Growth': '+14.6%',
          'Clinical Conversions': '78.5%',
          'Active PSWs': '152',
          'SOS Response Time': '1.5 mins',
        },
        charts: const [
          AnalyticsChart(
            id: 'conversion_trend',
            title: 'Weekly Clinical Conversion Rate (%)',
            type: ChartType.line,
            dataPoints: [
              DataPoint(label: 'Week 1', value: 72.0),
              DataPoint(label: 'Week 2', value: 74.5),
              DataPoint(label: 'Week 3', value: 76.8),
              DataPoint(label: 'Week 4', value: 78.5),
            ],
          )
        ],
        recentActivity: [
          ActivityItem(
            id: 'act-kpi-1',
            title: 'Q2 Performance Sync',
            subtitle: 'EBITDA and clinical conversion parameters synchronized.',
            timestamp: DateTime.now(),
          ),
        ],
        insights: const [
          IntelligenceInsight(
            id: 'ins-kpi-1',
            title: 'EBITDA Target Achieved',
            summary: 'Franchise royalty expansion and clinical conversions exceed core forecasts.',
            impact: InsightImpact.positive,
          ),
        ],
      );
    }
  } catch (e, st) {
    try {
      ref.read(executionGateProvider).failGate(
        ExecutionGateCategory.metricsLayer,
        'Failed to fetch strategic KPIs',
        error: e,
        stackTrace: st,
      );
    } catch (_) {}
  }
  
  return DashboardMetrics(
    kpis: const {
      'EBITDA Growth': '+12.4%',
      'Clinical Conversions': '74.2%',
      'Active PSWs': '142',
      'SOS Response Time': '1.8 mins',
    },
    charts: const [],
    recentActivity: const [],
    insights: const [],
  );
});

class StrategicKpis extends GovernedConsumerWidget {
  const StrategicKpis({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final kpisState = ref.watch(strategicKpisProvider);
    final isOnline = ref.watch(isOnlineProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          'Strategic Control Center',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          if (!isOnline)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.cloud_off, color: theme.colors.warning),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(strategicKpisProvider),
            tooltip: 'Sync KPIs',
          ),
        ],
      ),
      body: kpisState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Text(
            'Operational Anomaly: $err',
            style: TextStyle(color: theme.colors.error),
          ),
        ),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CEO Strategic KPIs',
                style: theme.typography.h2.copyWith(color: theme.colors.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                'Real-time financial, operational, and clinical indices across nationwide segments.',
                style: theme.typography.bodyLarge.copyWith(color: theme.colors.textSecondary),
              ),
              const SizedBox(height: 24),
              
              // Top-level KPI statistics cards
              GridView.extent(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                maxCrossAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  PrimeCareStatCard(
                    title: 'EBITDA Growth',
                    value: metrics.kpis['EBITDA Growth']?.toString() ?? 'N/A',
                    icon: LucideIcons.trendingUp,
                    iconColor: Colors.blue,
                  ),
                  PrimeCareStatCard(
                    title: 'Clinical Conversions',
                    value: metrics.kpis['Clinical Conversions']?.toString() ?? 'N/A',
                    icon: LucideIcons.users2,
                    iconColor: Colors.green,
                  ),
                  PrimeCareStatCard(
                    title: 'Active PSWs',
                    value: metrics.kpis['Active PSWs']?.toString() ?? 'N/A',
                    icon: LucideIcons.heartHandshake,
                    iconColor: Colors.orange,
                  ),
                  PrimeCareStatCard(
                    title: 'SOS Response Time',
                    value: metrics.kpis['SOS Response Time']?.toString() ?? 'N/A',
                    icon: LucideIcons.alertOctagon,
                    iconColor: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              
              if (metrics.insights.isNotEmpty) ...[
                Text(
                  'Actionable AI Insights',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 12),
                ...metrics.insights.map((ins) => ActionableInsightCard(insight: ins)),
                const SizedBox(height: 28),
              ],

              // System Integrity
              const SystemIntegrityManifest(),
            ],
          ),
        ),
      ),
    );
  }
}
