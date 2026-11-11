// Governance - Category: service | Purpose: Core implementation file for the Premium Feature 230 platform logic.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

final premiumFeature230Provider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/premium/model230');
  return response.data is Map ? Map<String, dynamic>.from(response.data as Map) : {};
});

class PremiumFeature230 extends GovernedConsumerWidget {
  const PremiumFeature230({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(premiumFeature230Provider);

    return Scaffold(
      backgroundColor:  theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color:  theme.colors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child:  Text(
                'PREMIUM', // .tr() LocaleKeys.
                style: TextStyle(
                  color: theme.colors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Feature 230 - Model230', // .tr() LocaleKeys.
              style:  TextStyle(
                color: theme.colors.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(key: const Key('premium_feature_230_iconbutton_button_1'), 
            icon:  Icon(Icons.tune, color: theme.colors.onSurfaceVariant),
            onPressed: () {},
          ),
          IconButton(key: const Key('premium_feature_230_iconbutton_button_2'), 
            icon:  Icon(Icons.notifications_outlined, color: theme.colors.onSurfaceVariant),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: dataState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PrimeStatusIcon(Icons.error_outline, tone: PrimeStatusTone.error, size: 48),
              const SizedBox(height: 16),
              Text(
                'Hydration Failure: $error', // .tr() LocaleKeys.
                style:  TextStyle(color: theme.colors.error, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        data: (data) => ResponsiveSplitDashboard(
          metrics:  [
            _StatCard(
              title: 'Telemetry Node Health', // .tr() LocaleKeys.
              value: '99.98%', // .tr() LocaleKeys.
              change: '+0.02%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.hub,
              color: theme.colors.primary,
            ),
            _StatCard(
              title: 'API Request Latency', // .tr() LocaleKeys.
              value: '14.2 ms', // .tr() LocaleKeys.
              change: '-2.4 ms', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.speed,
              color: Color(0xFF0EA5E9),
            ),
            _StatCard(
              title: 'Data Ingestion Rate', // .tr() LocaleKeys.
              value: '4,821 rps', // .tr() LocaleKeys.
              change: '+18.4%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.cloud_download,
              color: Color(0xFF10B981),
            ),
            _StatCard(
              title: 'Governance Violations', // .tr() LocaleKeys.
              value: '0 entries', // .tr() LocaleKeys.
              change: '0.00%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.gavel,
              color: Color(0xFFF59E0B),
            ),
          ],
          mainContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Analytical Intelligence Dashboard', // .tr() LocaleKeys.
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colors.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Live operational data and security posture auditing for Model230 schema bindings.', // .tr() LocaleKeys.
                style: TextStyle(
                  fontSize: 13.5,
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 380,
                maxItemWidth: 600,
                spacing: 24,
                children: [
                  _TelemetryPanel(
                    modelName: 'Model230',
                    data: data,
                    themeColor: theme.colors.primary,
                  ),
                  const _AuditPanel(
                    modelName: 'Model230',
                    themeColor: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
          defaultSidebarWidgets: [
            QuickActionsPanel(
              title: 'Operation Actions', // .tr() LocaleKeys.
              actions: [
                QuickActionItem(
                  label: 'Purge Buffers', // .tr() LocaleKeys.
                  icon: Icons.cleaning_services,
                  color: theme.colors.primary,
                  onTap: () {},
                ),
                QuickActionItem(
                  label: 'Trigger Audit', // .tr() LocaleKeys.
                  icon: Icons.shield,
                  color: const Color(0xFF0EA5E9),
                  onTap: () {},
                ),
                QuickActionItem(
                  label: 'Sync Schema', // .tr() LocaleKeys.
                  icon: Icons.sync,
                  color: const Color(0xFF10B981),
                  onTap: () {},
                ),
                QuickActionItem(
                  label: 'Export Logs', // .tr() LocaleKeys.
                  icon: Icons.download,
                  color: const Color(0xFFF59E0B),
                  onTap: () {},
                ),
              ],
            ),
             RecentActivityFeed(
              title: 'Governance Audit Trail', // .tr() LocaleKeys.
              activities: [
                PortalActivityItem(
                  title: 'Prisma Client Hydration', // .tr() LocaleKeys.
                  description: 'Synchronized telemetry mapping against database node.', // .tr() LocaleKeys.
                  time: '2m ago', // .tr() LocaleKeys.
                  icon: Icons.cloud_done,
                  color: Color(0xFF10B981),
                ),
                PortalActivityItem(
                  title: 'Zero-Trust Audit Log', // .tr() LocaleKeys.
                  description: 'Verified tenant credentials with secure authentication.', // .tr() LocaleKeys.
                  time: '1h ago', // .tr() LocaleKeys.
                  icon: Icons.lock,
                  color: theme.colors.primary,
                ),
                PortalActivityItem(
                  title: 'Telemetry Session Start', // .tr() LocaleKeys.
                  description: 'Established active stream listener on /v1/premium/model230.', // .tr() LocaleKeys.
                  time: '3h ago', // .tr() LocaleKeys.
                  icon: Icons.play_arrow,
                  color: Color(0xFF0EA5E9),
                ),
              ],
            ),
            const AiInsightsCard(
              heading: 'Performance Posture', // .tr() LocaleKeys.
              suggestions: [
                'Optimize ingestion latency by scaling local CDN nodes.', // .tr() LocaleKeys.
                'Zero active security threats detected; telemetry healthy.', // .tr() LocaleKeys.
                'Review database schema caching strategies for next sprint.', // .tr() LocaleKeys.
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.12),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                icon,
                size: 100,
                color: color.withOpacity(0.04),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          icon,
                          color: color,
                          size: 22,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isPositive ? theme.colors.success.withOpacity(0.1) : theme.colors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isPositive ? theme.colors.success : theme.colors.warning,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            PrimeTrendLabel(change, isPositive: isPositive),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    value,
                    style:  TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.colors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TelemetryPanel extends StatelessWidget {
  final String modelName;
  final Map<String, dynamic> data;
  final Color themeColor;

  const _TelemetryPanel({
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
class _AuditPanel extends StatelessWidget {
  final String modelName;
  final Color themeColor;

  const _AuditPanel({
    required this.modelName,
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
                    color: theme.colors.warning.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: PrimeIcon(Icons.gavel, color: theme.colors.warning, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeText(
                      'COMPLIANCE & GOVERNANCE', // .tr() LocaleKeys.
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: theme.colors.warning,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '$modelName Audit Ledger', // .tr() LocaleKeys.
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
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                PrimeStatusBadge('HIPAA Compliant', tone: PrimeStatusTone.success), // .tr() LocaleKeys.
                PrimeStatusBadge('GDPR Verified', tone: PrimeStatusTone.success), // .tr() LocaleKeys.
                PrimeStatusBadge('TLS 1.3 Active', tone: PrimeStatusTone.success), // .tr() LocaleKeys.
              ],
            ),
            const SizedBox(height: 24),
            PrimeTelemetryRow(
              label: 'Prisma Schema Bindings', // .tr() LocaleKeys.
              value: 'Verified UUID Entity', // .tr() LocaleKeys.
              icon: Icons.dns,
              color: theme.colors.primary,
            ),
            const Divider(height: 24),
            PrimeTelemetryRow(
              label: 'Encryption Standard', // .tr() LocaleKeys.
              value: 'AES-256 GCM', // .tr() LocaleKeys.
              icon: Icons.enhanced_encryption,
              color: theme.colors.secondary,
            ),
            const Divider(height: 24),
            PrimeTelemetryRow(
              label: 'Audit Trail Signature', // .tr() LocaleKeys.
              value: 'SHA-256 HMAC', // .tr() LocaleKeys.
              icon: Icons.fingerprint,
              color: theme.colors.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
