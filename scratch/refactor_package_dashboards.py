import os

files_to_refactor = {
    "packages/primecare_ui/lib/src/screens/common/chiropractor_dashboard_screen.dart": {
        "role": "Chiropractor",
        "title": "Chiropractor Control Center",
        "prefix": "chiropractordashboard",
        "provider": "chiropractorDashboardProvider",
    },
    "packages/primecare_ui/lib/src/screens/common/physiotherapist_dashboard_screen.dart": {
        "role": "Physiotherapist",
        "title": "Physiotherapist Control Center",
        "prefix": "physiotherapistdashboard",
        "provider": "physiotherapistDashboardProvider",
    },
    "packages/primecare_ui/lib/src/screens/common/social_worker_dashboard_screen.dart": {
        "role": "SocialWorker",
        "title": "Social Worker Control Center",
        "prefix": "socialworkerdashboard",
        "provider": "socialWorkerDashboardProvider",
    },
    "packages/primecare_ui/lib/src/screens/allied/rmt_dashboard_screen.dart": {
        "role": "Rmt",
        "title": "RMT Therapy Dashboard",
        "prefix": "rmtdashboard",
        "provider": "rmtDashboardProvider",
        "is_rmt": True,
    },
    "packages/primecare_ui/lib/src/screens/staff/intake_coordinator_dashboard_screen.dart": {
        "role": "IntakeCoordinator",
        "title": "Intake Coordinator Control Center",
        "prefix": "intakecoordinatordashboard",
        "provider": "intakeCoordinatorDashboardProvider",
    },
    "packages/primecare_ui/lib/src/screens/staff/training_coordinator_dashboard_screen.dart": {
        "role": "TrainingCoordinator",
        "title": "Training Coordinator Control Center",
        "prefix": "trainingcoordinatordashboard",
        "provider": "trainingCoordinatorDashboardProvider",
    },
    "packages/primecare_ui/lib/src/screens/staff/quality_assurance_dashboard_screen.dart": {
        "role": "QualityAssurance",
        "title": "Quality Assurance Dashboard",
        "prefix": "qualityassurancedashboard",
        "provider": "qualityAssuranceDashboardProvider",
    },
    "packages/primecare_ui/lib/src/screens/psw/psw_dashboard_screen.dart": {
        "role": "Psw",
        "title": "Psw Control Center",
        "prefix": "pswdashboard",
        "provider": "pswDashboardControllerProvider",
        "is_psw": True,
    },
    "packages/primecare_ui/lib/src/screens/clinical/physician_dashboard_screen.dart": {
        "role": "Physician",
        "title": "Physician Dashboard",
        "prefix": "physiciandashboard",
        "provider": "physicianDashboardControllerProvider",
    },
}

def refactor_file(file_path, info):
    print(f"Refactoring {file_path}...")
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    role = info["role"]
    title = info["title"]
    prefix = info["prefix"]
    provider = info["provider"]
    is_rmt = info.get("is_rmt", False)

    # Find the view class start
    view_class_pattern = f"class {role}DashboardScreen extends GovernedConsumerWidget"
    view_start = content.find(view_class_pattern)
    if view_start == -1:
        print(f"  Error: Could not find view class {view_class_pattern} in {file_path}")
        return

    # Keep everything before the view class
    header = content[:view_start]

    # Build the RMT specific widget injection
    rmt_appointments_block = ""
    if is_rmt:
        rmt_appointments_block = """
                const SizedBox(height: 24),
                // Active Sessions List
                PrimeCareCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Massage Appointments & SOAP Notes',
                        style: theme.typography.h3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...state.appointments.map(
                        (apt) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.colors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      apt.patientName,
                                      style: theme.typography.bodyLarge
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      apt.status,
                                      style: TextStyle(
                                        color: apt.status == 'Active'
                                            ? Colors.green
                                            : theme.colors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${apt.treatmentType} | ${apt.timeSlot}',
                                  style: theme.typography.bodyMedium.copyWith(
                                    color: theme.colors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      key: Key('rmtdashboard-btn-3-${apt.id}'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colors.primary,
                                      ),
                                      onPressed: () =>
                                          controller.createSoapNote(
                                            apt.id,
                                            'Myofascial tightness resolved.',
                                          ),
                                      child: const Text(
                                        'Save SOAP Chart note',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      key: Key('rmtdashboard-btn-4-${apt.id}'),
                                      onPressed: () => controller
                                          .submitInsuranceClaim(apt.id),
                                      child: Text(
                                        'Submit Direct Billing claim'.tr(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),"""

    template_view_class = """class __ROLE__DashboardScreen extends GovernedConsumerWidget {
  const __ROLE__DashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(__PROVIDER__);
    final controller = ref.read(__PROVIDER__.notifier);
    final theme = context.theme;
    final roleBase = '__ROLE__';

    return Cy(
      id: '__PREFIX__-screen data-cy:__PREFIX__-screen',
      child: Scaffold(
        key: const Key('__PREFIX__-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('__PREFIX__-title'),
            state.title.tr(),
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('__PREFIX__-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.addLog('Manual refresh triggered.'),
            ),
          ],
        ),
        body: ResponsiveSplitDashboard(
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
                label: 'data-cy:__PREFIX__-title',
                child: GovDashboardHero(
                  title: '__TITLE__',
                  roleName: '$roleBase Dashboard',
                  description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
                  onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
                ),
              ),
              const SizedBox(height: 24),
              GovTelemetryChart(
                title: 'Hourly Core Telemetry',
                dataPoints: const [75, 82, 80, 94, 91, 98],
                labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
                accentColor: theme.colors.primary,
              ),__RMT_APPOINTMENTS__
            ],
          ),
          defaultSidebarWidgets: [
            // === Executive Pill Action Button ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                key: const Key('__PREFIX__-btn-2'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primaryContainer,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: theme.colors.primary.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                icon: const Icon(LucideIcons.playCircle, size: 18),
                onPressed: () => controller.triggerStateAction(),
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
                  ...state.logs.map(
                    (log) => Padding(
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
                              log.tr(),
                              style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      key: const Key('__PREFIX__-btn-3'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: state.isLoading
                          ? null
                          : () => controller.runComplianceScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                key: Key('__PREFIX__-loading'),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Operational Audit Scan'.tr(),
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
"""

    new_view_class = (template_view_class
                      .replace("__ROLE__", role)
                      .replace("__TITLE__", title)
                      .replace("__PREFIX__", prefix)
                      .replace("__PROVIDER__", provider)
                      .replace("__RMT_APPOINTMENTS__", rmt_appointments_block))

    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(header + new_view_class)
    print(f"  Successfully refactored {file_path}")

for path, info in files_to_refactor.items():
    refactor_file(os.path.join(os.getcwd(), path), info)
