import 'dart:io';

void main() {
  final dir = Directory('packages/primecare_ui/lib/src/screens');
  if (!dir.existsSync()) {
    print('Screens directory not found!');
    exit(1);
  }

  int processedCount = 0;

  dir.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('_screen.dart')) {
      final fileName = entity.uri.pathSegments.last;
      
      // Exclude custom/hand-written screens that don't need bulk component injection
      if (fileName == 'psw_messages_screen.dart' ||
          fileName == 'psw_visit_notes_screen.dart' ||
          fileName == 'shared_screen_stubs.dart') {
        return;
      }

      final content = entity.readAsStringSync();
      
      // Check if it matches our standard MVC generated screens
      if (!content.contains('extends GovernedConsumerWidget')) {
        return;
      }

      // Regex to find class name
      final classRegex = RegExp(r'class\s+(\w+)\s+extends\s+GovernedConsumerWidget');
      final classMatch = classRegex.firstMatch(content);
      if (classMatch == null) return;
      final screenName = classMatch.group(1)!;

      // Regex to find provider name
      final providerRegex = RegExp(r'final\s+(\w+Provider)\s*=\s*StateNotifierProvider');
      final providerMatch = providerRegex.firstMatch(content);
      if (providerMatch == null) return;
      final providerName = providerMatch.group(1)!;

      String newClassContent = '';

      if (fileName.endsWith('_dashboard_screen.dart')) {
        // Generate Dashboard screen replacement
        newClassContent = '''
class $screenName extends GovernedConsumerWidget {
  const $screenName({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch($providerName);
    final controller = ref.read($providerName.notifier);
    final theme = context.theme;
    final roleBase = '$screenName'.replaceAll('DashboardScreen', '').replaceAll('Screen', '');

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual refresh triggered.'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: state.title,
              roleName: '\$roleBase Dashboard',
              description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
              onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GovMetricCard(
                    title: 'Active Operations',
                    value: 'Active',
                    trendLabel: 'Optimal productivity',
                    progress: 0.92,
                    icon: LucideIcons.activity,
                    brandColor: theme.colors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GovMetricCard(
                    title: 'Security Clearance',
                    value: 'Level 4 Approved',
                    trendLabel: 'Zero exceptions logged',
                    progress: 1.0,
                    icon: LucideIcons.shieldCheck,
                    brandColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GovTelemetryChart(
              title: 'Hourly Core Telemetry',
              dataPoints: const [75, 82, 80, 94, 91, 98],
              labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
              accentColor: theme.colors.primary,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operational Audit Logs',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...state.logs.map((log) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                log,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: state.isLoading ? null : () => controller.runComplianceScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Operational Audit Scan',
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
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
''';
      } else if (fileName.endsWith('_compliance_screen.dart')) {
        // Generate Compliance/Reports screen replacement
        newClassContent = '''
class $screenName extends GovernedConsumerWidget {
  const $screenName({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch($providerName);
    final controller = ref.read($providerName.notifier);
    final theme = context.theme;
    final roleBase = '$screenName'.replaceAll('ComplianceScreen', '').replaceAll('Screen', '');

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual refresh triggered.'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: state.title,
              roleName: '\$roleBase Invariants',
              description: 'Operational compliance checks, dynamic security policies, and secure ingestion forms.',
              onRefresh: () => controller.addLog('Compliance status scanned.'),
            ),
            const SizedBox(height: 24),
            GovSettingsPanel(
              title: 'Governance Directives',
              items: const [
                GovSettingsItem(
                  id: 'enforce_mfa',
                  name: 'Enforce MFA Authentication',
                  description: 'Mandate multi-factor security clearance for all sessions.',
                  initialValue: true,
                ),
                GovSettingsItem(
                  id: 'audit_telemetry',
                  name: 'Real-time System Audit Telemetry',
                  description: 'Stream automated invariant telemetry logs directly.',
                  initialValue: true,
                ),
              ],
              onToggled: (id, val) {
                controller.addLog('Policy update: \$id set to \$val');
              },
            ),
            const SizedBox(height: 24),
            GovIngestionForm(
              title: 'Secure Event Reporting Ingestion',
              buttonLabel: 'Submit Secure Form Logs',
              fields: const [
                'Inbound Event Classification',
                'Operational Priority Descriptor',
                'Authorized System Signature',
              ],
              onSubmit: (data) {
                controller.addLog(
                  'Ingested secure submission: Priority=\${data['Operational Priority Descriptor'] ?? 'N/A'}, Event=\${data['Inbound Event Classification'] ?? 'N/A'}',
                );
              },
            ),
            const SizedBox(height: 24),
            GovComplianceAuditTable(
              title: 'Recent Compliance Verification Audits',
              columns: const ['Identifier', 'Authorized Signature', 'Status'],
              data: const [
                {
                  'Identifier': 'AUD-9981-A',
                  'Authorized Signature': 'SYSTEM_SECURE_BYPASS',
                  'Status': 'COMPLIANT',
                },
                {
                  'Identifier': 'AUD-9982-B',
                  'Authorized Signature': 'GOV_ENGINE_INV_SYNC',
                  'Status': 'COMPLIANT',
                },
                {
                  'Identifier': 'AUD-9983-C',
                  'Authorized Signature': 'SYSTEM_SECURE_BYPASS',
                  'Status': 'COMPLIANT',
                },
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operational Audit Logs',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...state.logs.map((log) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                log,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: state.isLoading ? null : () => controller.runComplianceScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Compliance Audit Scan',
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
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
''';
      }

      if (newClassContent.isNotEmpty) {
        // Find the index of class declaration and cut the file there
        final classDecl = 'class $screenName extends GovernedConsumerWidget';
        final startIndex = content.indexOf(classDecl);
        if (startIndex != -1) {
          final preamble = content.substring(0, startIndex);
          final updatedContent = preamble + newClassContent;
          entity.writeAsStringSync(updatedContent);
          processedCount++;
        }
      }
    }
  });

  print('Successfully processed $processedCount screens!');
}
