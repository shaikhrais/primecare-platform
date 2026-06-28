/* 
PRIME:SCREEN=verification_center
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_BASIC
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=70
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/deployment_sync_service.dart';
import '../../../../core/database/governance_database.dart';

// State provider for displaying detailed crawler logs in an overlay modal
final activeLogViewProvider = StateProvider<PlatformDeployment?>((ref) => null);

class VerificationCenterScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display deployment statuses, buttons for accessing logs and live links, functions for data retrieval and interaction, and APIs for fetching deployment information.';

  @override
  List<String> get requiredComponents => const [
        'SummaryCard',
        'DeploymentList',
        'LoadingIndicator',
        'ErrorMessage',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchDeploymentData',
        'viewDeploymentLogs',
        'launchLiveLink',
      ];

  const VerificationCenterScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final deploymentsState = ref.watch(localDeploymentsProvider);
    final activeLogDep = ref.watch(activeLogViewProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    deploymentsState.when(
                      data: (deployments) {
                        final successCount = deployments.where((d) => d.status == 'success').length;
                        final verifiedCount = deployments.where((d) => d.verified).length;

                        return Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top Summary Cards Row
                              Row(
                                children: [
                                  _buildSummaryCard(
                                    context,
                                    '${deployments.length}',
                                    'Apps Tracked',
                                    LucideIcons.globe,
                                    Colors.indigo,
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSummaryCard(
                                    context,
                                    '$successCount',
                                    'Deployments Online',
                                    LucideIcons.checkCircle2,
                                    Colors.green,
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSummaryCard(
                                    context,
                                    '$verifiedCount',
                                    'Verified E2E Checks',
                                    LucideIcons.shieldCheck,
                                    Colors.teal,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              Text(
                                'Cloudflare Pages Live Handshake Log',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),

                              // Table/List of deployments
                              Expanded(
                                child: ListView.builder(
                                  itemCount: deployments.length,
                                  itemBuilder: (context, index) {
                                    final d = deployments[index];
                                    return _buildDeploymentItem(context, ref, d);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      loading: () => const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Loading SQLite deployment registries...'),
                          ],
                        ),
                      ),
                      error: (err, _) => Center(child: Text('Error loading deployments: $err')),
                    ),
                  ],
                ),
              ),

              // Overlay log viewer Modal
              if (activeLogDep != null) _buildLogViewerOverlay(context, ref, activeLogDep),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(LucideIcons.activity, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text(
              'Deployment & Verification Center',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Monorepo compilation, live handshakes, role authentication checks and test logs',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context, String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 0.5,
        color: color.withOpacity(0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withOpacity(0.12), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color),
                  ),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeploymentItem(BuildContext context, WidgetRef ref, PlatformDeployment d) {
    final bool isSuccess = d.status == 'success';
    final Uri? targetUrl = d.buildUrl != null ? Uri.parse(d.buildUrl!) : null;

    return Card(
      key: ValueKey('data-cy-deploy-card-${d.appName}'),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
        child: Row(
          children: [
            // Status Icon with neon ring
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (isSuccess ? Colors.green : Colors.red).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? LucideIcons.globe : LucideIcons.alertOctagon,
                color: isSuccess ? Colors.green : Colors.red,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),

            // App Name & Target Platform
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.appName.replaceAll('_', ' ').toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        d.platform == 'web' ? LucideIcons.globe : LucideIcons.tablet,
                        size: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        d.platform.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Target URL Link Badge
            if (targetUrl != null)
              OutlinedButton.icon(
                key: ValueKey('data-cy-live-link-${d.appName}'),
                onPressed: () async {
                  if (await canLaunchUrl(targetUrl)) {
                    await launchUrl(targetUrl);
                  }
                },
                icon: const Icon(LucideIcons.externalLink, size: 12),
                label: const Text('Live Link', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  minimumSize: Size.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            const SizedBox(width: 12),

            // Crawling & Verification Badges
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: d.verified ? Colors.green.withOpacity(0.1) : Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                d.verified ? 'Verified ✅' : 'Crawler Unchecked',
                style: TextStyle(
                  color: d.verified ? Colors.green : Colors.amber.shade800,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Logs Button
            ElevatedButton(
              key: ValueKey('data-cy-logs-btn-${d.appName}'),
              onPressed: () {
                ref.read(activeLogViewProvider.notifier).state = d;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                foregroundColor: Theme.of(context).colorScheme.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.terminal, size: 14),
                  SizedBox(width: 4),
                  Text('Logs', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogViewerOverlay(BuildContext context, WidgetRef ref, PlatformDeployment d) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      alignment: Alignment.center,
      child: Card(
        key: const ValueKey('data-cy-logs-viewer-card'),
        margin: const EdgeInsets.all(32),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xFF1E1E1E), // Premium terminal dark
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.terminal, color: Colors.greenAccent, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        'Crawl Verification Audit Log: ${d.appName.toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    key: const ValueKey('data-cy-logs-close-btn'),
                    onPressed: () => ref.read(activeLogViewProvider.notifier).state = null,
                    icon: const Icon(LucideIcons.x, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Console-like Log Container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      d.verificationLog ?? 'No crawling logs captured.',
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Bottom Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  key: const ValueKey('data-cy-logs-close-text-btn'),
                  onPressed: () => ref.read(activeLogViewProvider.notifier).state = null,
                  child: const Text('Close Log Viewer', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

