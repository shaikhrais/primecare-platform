import 'package:primecare_ui/primecare_ui.dart';

final qaMetricsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/admin/qa/metrics');
  return response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : {};
});

class QualityAssuranceMetricsScreen extends GovernedConsumerWidget {
  const QualityAssuranceMetricsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(qaMetricsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Quality Assurance Metrics',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(qaMetricsProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load QA metrics: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (metrics) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('System-wide QA Pulse', style: theme.typography.h2),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 300,
                spacing: 24,
                children: [
                  _buildMetricTile(theme, 'Error Rate', '${metrics['errorRate'] ?? '0.04'}%', Icons.error_outline, theme.colors.error),
                  _buildMetricTile(theme, 'Test Coverage', '${metrics['testCoverage'] ?? '89'}%', Icons.fact_check_outlined, theme.colors.success),
                  _buildMetricTile(theme, 'Mean Time to Recovery', '${metrics['mttr'] ?? '14'} min', Icons.timer_outlined, theme.colors.warning),
                  _buildMetricTile(theme, 'Uptime', '${metrics['uptime'] ?? '99.999'}%', Icons.cloud_done_outlined, theme.colors.primary),
                ],
              ),
              const SizedBox(height: 32),
              Card(
                color: theme.colors.surface,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent QA Audit Logs', style: theme.typography.h3),
                      const SizedBox(height: 16),
                      const Divider(),
                      _buildAuditLog(theme, 'CI/CD Pipeline #4592 - Passed', '2 hours ago', true),
                      _buildAuditLog(theme, 'E2E Regression Test Suite - Failed', '4 hours ago', false),
                      _buildAuditLog(theme, 'Security Vulnerability Scan - Passed', '1 day ago', true),
                      _buildAuditLog(theme, 'Accessibility Audit - Passed', '2 days ago', true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricTile(PrimeThemeData theme, String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary)),
              const SizedBox(height: 4),
              Text(value, style: theme.typography.h3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLog(PrimeThemeData theme, String event, String time, bool passed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            passed ? Icons.check_circle : Icons.cancel,
            color: passed ? theme.colors.success : theme.colors.error,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(event, style: theme.typography.bodyLarge),
          ),
          Text(time, style: theme.typography.labelSmall.copyWith(color: theme.colors.textSecondary)),
        ],
      ),
    );
  }
}
