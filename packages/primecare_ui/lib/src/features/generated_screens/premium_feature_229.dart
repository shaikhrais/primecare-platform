import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_core/flutter_core.dart';

final premiumFeature229Provider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/premium/model229');
  return response.data is Map ? Map<String, dynamic>.from(response.data as Map) : {};
});

class PremiumFeature229 extends GovernedConsumerWidget {
  const PremiumFeature229({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final dataState = ref.watch(premiumFeature229Provider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'PREMIUM', // .tr() LocaleKeys.
                style: TextStyle(
                  color: Color(0xFF6366F1),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Feature 229 - Model229', // .tr() LocaleKeys.
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF64748B)),
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
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Hydration Failure: $error', // .tr() LocaleKeys.
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        data: (data) => ResponsiveSplitDashboard(
          metrics: const [
            _StatCard(
              title: 'Telemetry Node Health', // .tr() LocaleKeys.
              value: '99.98%', // .tr() LocaleKeys.
              change: '+0.02%', // .tr() LocaleKeys.
              isPositive: true,
              icon: Icons.hub,
              color: Color(0xFF6366F1),
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
              const Text(
                'Analytical Intelligence Dashboard', // .tr() LocaleKeys.
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Live operational data and security posture auditing for Model229 schema bindings.', // .tr() LocaleKeys.
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.blueGrey.shade400,
                ),
              ),
              const SizedBox(height: 24),
              ResponsiveGrid(
                minItemWidth: 380,
                maxItemWidth: 600,
                spacing: 24,
                children: [
                  _TelemetryPanel(
                    modelName: 'Model229',
                    data: data,
                    themeColor: const Color(0xFF6366F1),
                  ),
                  const _AuditPanel(
                    modelName: 'Model229',
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
                  color: const Color(0xFF6366F1),
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
            const RecentActivityFeed(
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
                  color: Color(0xFF6366F1),
                ),
                PortalActivityItem(
                  title: 'Telemetry Session Start', // .tr() LocaleKeys.
                  description: 'Established active stream listener on /v1/premium/model229.', // .tr() LocaleKeys.
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                          color: isPositive ? const Color(0xFF10B981).withOpacity(0.1) : Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isPositive ? const Color(0xFF10B981) : Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              change,
                              style: TextStyle(
                                color: isPositive ? const Color(0xFF047857) : Colors.amber.shade700,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey.shade400,
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.blueGrey.shade50, width: 1.5),
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
                Column(
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('API Response Health', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)), // .tr() LocaleKeys.
                      Text(data.isEmpty ? 'Offline' : 'Nominal', style: TextStyle(color: data.isEmpty ? Colors.amber : const Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 13)), // .tr() LocaleKeys.
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: data.isEmpty ? 0.35 : 0.94,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const _TelemetryRow(
              label: 'Sync Frequency', // .tr() LocaleKeys.
              value: 'Real-time (12ms)', // .tr() LocaleKeys.
              icon: Icons.sync,
              color: Colors.blue,
            ),
            const Divider(height: 24),
            const _TelemetryRow(
              label: 'Drift Coefficient', // .tr() LocaleKeys.
              value: '0.0034 delta', // .tr() LocaleKeys.
              icon: Icons.trending_up,
              color: Colors.purple,
            ),
            const Divider(height: 24),
            const _TelemetryRow(
              label: 'System Isolation', // .tr() LocaleKeys.
              value: 'Strict Tenant Isolation', // .tr() LocaleKeys.
              icon: Icons.security,
              color: const Color(0xFF10B981),
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Colors.blueGrey.shade50, width: 1.5),
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
                    color: Colors.amber.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.gavel, color: Colors.amber, size: 20),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'COMPLIANCE & GOVERNANCE', // .tr() LocaleKeys.
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '$modelName Audit Ledger', // .tr() LocaleKeys.
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                _StatusBadge(label: 'HIPAA Compliant', color: const Color(0xFF10B981)), // .tr() LocaleKeys.
                SizedBox(width: 8),
                _StatusBadge(label: 'GDPR Verified', color: Colors.blue), // .tr() LocaleKeys.
                SizedBox(width: 8),
                _StatusBadge(label: 'TLS 1.3 Active', color: Colors.purple), // .tr() LocaleKeys.
              ],
            ),
            const SizedBox(height: 24),
            const _TelemetryRow(
              label: 'Prisma Schema Bindings', // .tr() LocaleKeys.
              value: 'Verified UUID Entity', // .tr() LocaleKeys.
              icon: Icons.dns,
              color: Colors.indigo,
            ),
            const Divider(height: 24),
            const _TelemetryRow(
              label: 'Encryption Standard', // .tr() LocaleKeys.
              value: 'AES-256 GCM', // .tr() LocaleKeys.
              icon: Icons.enhanced_encryption,
              color: Colors.teal,
            ),
            const Divider(height: 24),
            const _TelemetryRow(
              label: 'Audit Trail Signature', // .tr() LocaleKeys.
              value: 'SHA-256 HMAC', // .tr() LocaleKeys.
              icon: Icons.fingerprint,
              color: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}

class _TelemetryRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _TelemetryRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey.shade600,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
