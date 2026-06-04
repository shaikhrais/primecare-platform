import os
import re

files_to_refactor = [
    "apps/primecare_clinic/lib/features/physician/screens/physician_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/psw/screens/psw_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/rn/screens/rn_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/chiropractor_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/clinical_director_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/intake_coordinator_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/physiotherapist_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/qa_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/receptionist_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/rmt_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/social_worker_dashboard_screen.dart",
    "apps/primecare_clinic/lib/features/shared/screens/training_coordinator_dashboard_screen.dart",
]

def refactor_file(file_path):
    print(f"Refactoring {file_path}...")
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Extract base names
    # Find btn-2 key, e.g. key: const Key('clinicaldirectordashboard-btn-2')
    btn2_match = re.search(r"key:\s*const\s*Key\('([^']+)-btn-2'\)", content)
    if not btn2_match:
        print(f"  Warning: No btn-2 key found in {file_path}")
        return
    prefix = btn2_match.group(1)

    # Find the title (usually inside the GovDashboardHero title parameter)
    hero_match = re.search(r"GovDashboardHero\(\s*title:\s*'([^']+)'", content)
    title = hero_match.group(1) if hero_match else "Dashboard"

    # Let's replace the state.when block
    # Find state.when start
    when_start = content.find("body: state.when(")
    if when_start == -1:
        print(f"  Warning: No body: state.when found in {file_path}")
        return

    # Find the matching closing parenthesis for state.when( ... )
    # Let's count parentheses
    paren_count = 0
    idx = when_start + len("body: state.when")
    while idx < len(content):
        if content[idx] == '(':
            paren_count += 1
        elif content[idx] == ')':
            paren_count -= 1
            if paren_count == 0:
                break
        idx += 1
    
    when_end = idx + 1
    
    # We want to keep:
    # - leading/trailing cy/semantics wrappers around the content if necessary
    # Wait, let's look at the structure of clinical_director_dashboard_screen.dart:
    # body: state.when(
    #   data: (data) => Cy(id: '...', child: SingleChildScrollView(...))
    #   loading: () => ...
    #   error: ...
    # )
    
    # Construct the upgraded responsive body
    new_when_block = f"""body: state.when(
          data: (data) => ResponsiveSplitDashboard(
            metrics: const [
              GovMetricCard(
                title: 'Active Operations',
                value: 'Active',
                trendLabel: 'Optimal',
                progress: 0.92,
                icon: LucideIcons.activity,
                brandColor: Color(0xFF0D9488),
              ),
              GovMetricCard(
                title: 'Security Clearance',
                value: 'Level 4',
                trendLabel: 'Approved',
                progress: 1.0,
                icon: LucideIcons.shieldCheck,
                brandColor: Color(0xFF16A34A),
              ),
              GovMetricCard(
                title: 'System Latency',
                value: '18ms',
                trendLabel: 'Optimal',
                progress: 0.98,
                icon: LucideIcons.zap,
                brandColor: Color(0xFFEAB308),
              ),
              GovMetricCard(
                title: 'Data Integrity',
                value: '99.9%',
                trendLabel: 'Secure',
                progress: 0.99,
                icon: LucideIcons.database,
                brandColor: Color(0xFF2563EB),
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'data-cy:{prefix}-title',
                  child: GovDashboardHero(
                    title: '{title}',
                    roleName: '$roleBase Dashboard',
                    description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                    onRefresh: () => controller.performAction(),
                  ),
                ),
                const SizedBox(height: 24),
                GovTelemetryChart(
                  title: 'Hourly Core Telemetry',
                  dataPoints: const [75, 82, 80, 94, 91, 98],
                  labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
                  accentColor: theme.colors.primary,
                ),
              ],
            ),
            defaultSidebarWidgets: [
              // === Executive Pill Action Button ===
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  key: const Key('{prefix}-btn-2'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primaryContainer,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: theme.colors.primary.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                  icon: const Icon(LucideIcons.playCircle, size: 18),
                  onPressed: () => controller.performAction(),
                  label: Text('Execute: Button 1'.tr()),
                ),
              ),
              const SizedBox(height: 24),
              // === Audit Logs Panel ===
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: theme.colors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Operational Audit Logs',
                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 12),
                    Padding(
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
                              'System initialized & security sync complete.',
                              style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        key: const Key('{prefix}-btn-3'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => controller.performAction(),
                        child: Text(
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
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        )"""

    new_content = content[:when_start] + new_when_block + content[when_end:]
    
    # Make sure we import ResponsiveSplitDashboard or that it is available.
    # ResponsiveSplitDashboard is in primecare_ui/primecare_ui.dart or packages/flutter_core/lib/registry/widgets/responsive_split_dashboard.dart
    # Let's check imports. Since we already import primecare_ui, wait, is ResponsiveSplitDashboard exported by primecare_ui or flutter_core?
    # Let's verify. In our grep results, packages/primecare_ui/lib/src/screens/executive/coo_dashboard_screen.dart uses ResponsiveSplitDashboard and it imports:
    # import 'package:primecare_ui/primecare_ui.dart';
    # This means primecare_ui exports it! So no extra imports are needed.

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"  Successfully refactored {file_path}")

for f in files_to_refactor:
    refactor_file(os.path.join(os.getcwd(), f))
