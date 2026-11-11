// Exact generated health panel with the production shared row renderer.
import 'package:primecare_ui/primecare_ui.dart';

class PremiumHealthPanelFixture extends StatelessWidget {
  final String modelName;
  final Map<String, dynamic> data;
  final Color themeColor;

  const PremiumHealthPanelFixture({
    required this.modelName,
    required this.data,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: theme.colors.outline, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.analytics, color: themeColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVE TELEMETRY STREAM', // .tr() LocaleKeys.
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '$modelName Data Drift Monitor', // .tr() LocaleKeys.
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colors.onSurface,
                      ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.colors.outline),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: const Text('API Response Health', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13))), // .tr() LocaleKeys.
                      const SizedBox(width: 12),
                      Flexible(child: Text(data.isEmpty ? 'Offline' : 'Nominal', style: TextStyle(color: data.isEmpty ? theme.colors.warning : theme.colors.success, fontWeight: FontWeight.bold, fontSize: 13))), // .tr() LocaleKeys.
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: PrimeLinearProgressIndicator(
                      value: data.isEmpty ? 0.35 : 0.94,
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimeTelemetryRow(
              label: 'Sync Frequency', // .tr() LocaleKeys.
              value: 'Real-time (12ms)', // .tr() LocaleKeys.
              icon: Icons.sync,
              color: theme.colors.primary,
            ),
            const Divider(height: 24),
            PrimeTelemetryRow(
              label: 'Drift Coefficient', // .tr() LocaleKeys.
              value: '0.0034 delta', // .tr() LocaleKeys.
              icon: Icons.trending_up,
              color: theme.colors.secondary,
            ),
            const Divider(height: 24),
            PrimeTelemetryRow(
              label: 'System Isolation', // .tr() LocaleKeys.
              value: 'Strict Tenant Isolation', // .tr() LocaleKeys.
              icon: Icons.security,
              color: theme.colors.success,
            ),
          ],
        ),
      ),
    );
  }
}
