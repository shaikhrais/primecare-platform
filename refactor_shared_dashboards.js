const fs = require('fs');
const path = require('path');

const SCREENS_DIR = path.join(__dirname, 'packages', 'primecare_ui', 'lib', 'src', 'screens');

// Standardized template buildScreen replacement generator
function generateUpgradedBuildScreen(className, providerName) {
  const roleBase = className.replace('DashboardScreen', '').replace('Screen', '');
  
  return `  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${providerName});
    final controller = ref.read(${providerName}.notifier);
    final theme = context.theme;
    final roleBase = '${className}'.replaceAll('DashboardScreen', '').replaceAll('Screen', '');

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
            onPressed: () => controller.addLog('Manual refresh triggered.'), // .tr() LocaleKeys.
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              GovMetricCard(
                title: 'Active Operations', // .tr() LocaleKeys.
                value: 'Active', // .tr() LocaleKeys.
                trendLabel: 'Optimal productivity', // .tr() LocaleKeys.
                progress: 0.92,
                icon: LucideIcons.activity,
                brandColor: theme.colors.primary,
              ),
              GovMetricCard(
                title: 'Security Clearance', // .tr() LocaleKeys.
                value: 'Level 4 Approved', // .tr() LocaleKeys.
                trendLabel: 'Zero exceptions logged', // .tr() LocaleKeys.
                progress: 1.0,
                icon: LucideIcons.shieldCheck,
                brandColor: Colors.green,
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GovDashboardHero(
                  title: state.title,
                  roleName: '\$roleBase Dashboard', // .tr() LocaleKeys.
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.', // .tr() LocaleKeys.
                  onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'), // .tr() LocaleKeys.
                ),
                const SizedBox(height: 24),
                GovTelemetryChart(
                  title: 'Hourly Core Telemetry', // .tr() LocaleKeys.
                  dataPoints: const [75, 82, 80, 94, 91, 98],
                  labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'], // .tr() LocaleKeys.
                  accentColor: theme.colors.primary,
                ),
              ],
            ),
            defaultSidebarWidgets: [
              QuickActionsPanel(
                title: 'Quick Actions', // .tr() LocaleKeys.
                actions: [
                  QuickActionItem(
                    label: 'Run Audit Scan', // .tr() LocaleKeys.
                    icon: LucideIcons.scan,
                    color: theme.colors.primary,
                    onTap: state.isLoading ? () {} : () => controller.runComplianceScan(),
                  ),
                  QuickActionItem(
                    label: 'Sync Posture', // .tr() LocaleKeys.
                    icon: LucideIcons.refreshCw,
                    color: Colors.green,
                    onTap: () => controller.addLog('Manual synchronization sweep triggered.'), // .tr() LocaleKeys.
                  ),
                  QuickActionItem(
                    label: 'Policy Update', // .tr() LocaleKeys.
                    icon: LucideIcons.shieldCheck,
                    color: Colors.blue,
                    onTap: () => controller.addLog('Security posture updated.'), // .tr() LocaleKeys.
                  ),
                  QuickActionItem(
                    label: 'Export Logs', // .tr() LocaleKeys.
                    icon: LucideIcons.download,
                    color: Colors.purple,
                    onTap: () => controller.addLog('Audit logs exported.'), // .tr() LocaleKeys.
                  ),
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
                      'Operational Audit Logs', // .tr() LocaleKeys.
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
                                'Execute Operational Audit Scan', // .tr() LocaleKeys.
                                style: theme.typography.button.copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const AiInsightsCard(
                heading: 'System & Policy Insights', // .tr() LocaleKeys.
                suggestions: [
                  'Ensure all ingress endpoints enforce TLS 1.3 encryption.', // .tr() LocaleKeys.
                  'Last automated compliance scan completed with 0 errors.', // .tr() LocaleKeys.
                  'Recommended key rotation lifetime set to 24 hours.', // .tr() LocaleKeys.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}`;
}

// Recurse directory and find all dashboard screen files
function getFilesRecursively(dir, fileList = []) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat.isDirectory()) {
      getFilesRecursively(filePath, fileList);
    } else if (file.endsWith('_dashboard_screen.dart')) {
      fileList.push(filePath);
    }
  }
  return fileList;
}

function run() {
  console.log(`Scanning screens directory: ${SCREENS_DIR}`);
  const files = getFilesRecursively(SCREENS_DIR);
  console.log(`Found ${files.length} dashboard screen files.`);

  let successCount = 0;
  let customCount = 0;
  let skippedCount = 0;

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf-8');
    const relativePath = path.relative(SCREENS_DIR, file);

    // Skip high-complexity custom files
    if (file.endsWith('ciso_dashboard_screen.dart') || 
        file.endsWith('cfo_dashboard_screen.dart') || 
        file.endsWith('coo_dashboard_screen.dart')) {
      console.log(`[CUSTOM] Skipping highly customized file for separate manual/custom refactor: ${relativePath}`);
      customCount++;
      continue;
    }

    // Extract provider name and class name to confirm if standard
    const providerMatch = content.match(/final state = ref\.watch\((\w+)\);/);
    const classMatch = content.match(/class (\w+Screen) extends GovernedConsumerWidget/);

    if (providerMatch && classMatch) {
      const providerName = providerMatch[1];
      const className = classMatch[1];

      // Match the standard buildScreen signature up to the end of class
      const buildScreenRegex = /Widget buildScreen\(BuildContext context, WidgetRef ref\) \{([\s\S]+?)\n  \}\n\}/;

      if (buildScreenRegex.test(content)) {
        const upgradedBuild = generateUpgradedBuildScreen(className, providerName);
        const newContent = content.replace(buildScreenRegex, upgradedBuild);
        
        fs.writeFileSync(file, newContent, 'utf-8');
        console.log(`[UPGRADED] Refactored standard dashboard: ${relativePath} (${className} using ${providerName})`);
        successCount++;
      } else {
        console.log(`[SKIPPED] Failed buildScreen regex match: ${relativePath}`);
        skippedCount++;
      }
    } else {
      console.log(`[SKIPPED] Missing provider/class signature: ${relativePath}`);
      skippedCount++;
    }
  }

  console.log('\nUpgrade Summary:');
  console.log(`- Successfully upgraded: ${successCount} standard dashboards`);
  console.log(`- Scheduled for manual refactoring: ${customCount} custom dashboards`);
  console.log(`- Skipped (already customized or non-standard): ${skippedCount}`);
}

run();
