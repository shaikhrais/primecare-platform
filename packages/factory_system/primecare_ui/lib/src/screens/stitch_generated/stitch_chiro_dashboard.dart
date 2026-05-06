import 'package:flutter_core/dashboard_providers.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/components/layouts/provider_layout.dart';

class StitchChiroDashboard extends ConsumerWidget {
  static const String className = 'StitchChiroDashboard';
  const StitchChiroDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    // The registry identifies screens by their ID, but here we use the class name as a fallback key for metrics.
    final metricsAsyncValue = ref.watch(dashboardMetricsProvider('StitchChiroDashboard'));

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ChiroDashboard',
              style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Stitch-generated Physical Screen.',
              style: theme.typography.bodyLarge.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: theme.spacing * 4),
            
            metricsAsyncValue.when(
              loading: () => Center(
                child: Padding(
                  padding: EdgeInsets.all(theme.spacing * 8),
                  child: CircularProgressIndicator(color: theme.colors.primary),
                ),
              ),
              error: (error, _) => _buildErrorState(theme, error.toString()),
              data: (dynamic liveData) => _buildDataState(context, theme, liveData),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(PrimeThemeData theme, String error) {
    return Container(
      padding: EdgeInsets.all(theme.spacing * 3),
      decoration: BoxDecoration(
        color: theme.colors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.alertTriangle, color: theme.colors.error),
          SizedBox(width: theme.spacing * 2),
          Expanded(
            child: Text(
              'Failed to load metrics for $className: \n$error',
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.error),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataState(BuildContext context, PrimeThemeData theme, dynamic data) {
    // SECURE API KEY INJECTION
    const String googleMapsApiKey = String.fromEnvironment(
      'GOOGLE_MAPS_API_KEY',
      defaultValue: 'UNSET_SECURE_KEY',
    );

    // Structural Reconciliation: Handling different model types if necessary.
    final DashboardMetrics metrics = (data is DashboardMetrics) ? data : DashboardMetrics.empty();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        

        GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: theme.spacing * 3,
          mainAxisSpacing: theme.spacing * 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: metrics.kpis.entries.map<Widget>((entry) {
            final value = entry.value;
            return PrimeCareStatCard(
              title: entry.key,
              value: value is Map ? (value['value']?.toString() ?? '0') : value.toString(),
              deltaSuffix: value is Map ? (value['trend']?.toString() ?? '') : '',
              icon: _inferIcon(entry.key),
              iconColor: _inferColor(theme, value is Map ? value['status']?.toString() : 'operational'),
            );
          }).toList(),
        ),
        SizedBox(height: theme.spacing * 5),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  PrimeCareCard(
                    padding: EdgeInsets.all(theme.spacing * 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Live Operations Feed',
                          style: theme.typography.h3,
                        ),
                        SizedBox(height: theme.spacing * 3),
                        if (metrics.recentActivity.isEmpty)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: theme.spacing * 4),
                              child: Text(
                                'No recent activity reported',
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ),
                        ...metrics.recentActivity.map<Widget>((activity) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: theme.spacing * 2),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(theme.spacing * 1.5),
                                  decoration: BoxDecoration(
                                    color: theme.colors.surfaceContainerHigh,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(LucideIcons.activity, color: theme.colors.primary, size: 20),
                                ),
                                SizedBox(width: theme.spacing * 2),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activity.title,
                                        style: theme.typography.labelBold,
                                      ),
                                      Text(
                                        activity.subtitle,
                                        style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  activity.timestamp.toIso8601String().substring(11, 16),
                                  style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                                    SizedBox(height: theme.spacing * 3),
                  // Logistics Map Placeholder
                  PrimeCareCard(
                    padding: EdgeInsets.zero,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: theme.colors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(LucideIcons.map, size: 48, color: theme.colors.outline),
                                SizedBox(height: 16),
                                Text(
                                  'Interactive Route Logistics',
                                  style: theme.typography.h3.copyWith(color: theme.colors.onSurfaceVariant),
                                ),
                                Text(
                                  'API Key Injection Verified: ${googleMapsApiKey != 'UNSET_SECURE_KEY' ? 'SECURE' : 'DEVELOPMENT'}',
                                  style: theme.typography.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radiusSm),
                                border: Border.all(color: theme.colors.outlineVariant),
                              ),
                              child: Text(
                                'Lat: 43.6532° N, Long: 79.3832° W',
                                style: theme.typography.labelMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            SizedBox(width: theme.spacing * 3),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(theme.spacing * 3),
                decoration: BoxDecoration(
                  color: theme.colors.primaryContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: theme.colors.primaryContainer.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Status',
                      style: theme.typography.h3.copyWith(color: theme.colors.primary),
                    ),
                    SizedBox(height: theme.spacing * 3),
                    _buildStatusRow(theme, LucideIcons.server, 'Core API URL', 'Connected', theme.colors.success),
                    SizedBox(height: theme.spacing * 2),
                    _buildStatusRow(theme, LucideIcons.database, 'Data Lake', 'Operational', theme.colors.success),
                    SizedBox(height: theme.spacing * 2),
                    _buildStatusRow(theme, LucideIcons.shieldCheck, 'Live Sync', 'Active', theme.colors.primary),
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

  Color _inferColor(PrimeThemeData theme, String? status) {
    final s = status?.toLowerCase() ?? '';
    if (s == 'operational' || s == 'positive' || s == 'up') return theme.colors.success;
    if (s == 'warning' || s == 'attention') return theme.colors.tertiary;
    if (s == 'critical' || s == 'down' || s == 'negative') return theme.colors.error;
    return theme.colors.primary;
  }

  Widget _buildStatusRow(PrimeThemeData theme, IconData icon, String label, String status, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: theme.spacing * 1.5),
        Text(label, style: theme.typography.bodyMedium),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: theme.typography.labelBold.copyWith(color: color, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
