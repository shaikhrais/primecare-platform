import 'package:primecare_models/src/models/clinical_director_dashboard_screen_state.dart';
export 'package:primecare_models/src/models/clinical_director_dashboard_screen_state.dart' show ClinicalDirectorDashboardState;
import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: view | Purpose: UI Screen component rendering the Care Director Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---

// This validates the existing screen's input needs, not an approved API contract.
void _validateClinicalDashboard(dynamic data) {
  if (data is! Map<String, dynamic>)
    throw const FormatException('Invalid dashboard');
  const integers = [
    'residentsToday',
    'staffOnShift',
    'openShifts',
    'fallsToday',
    'incidentsToday',
    'hospitalTransfers',
    'activeOutbreaks',
    'pressureUlcersCount',
    'wanderingAlertsCount',
    'missedRepositioningsCount',
    'weightLossRiskCount',
    'dehydrationAlertCount',
    'sickCalls',
    'agencyStaffUsage',
    'expiringCertifications',
    'missingADLChartingCount',
    'lateIncidentReportsCount',
    'overdueCarePlansCount',
    'privacyBreachCount',
    'activeAbuseInvestigationsCount',
    'activeInfectionsCount',
    'isolationCount',
    'activeComplaintsCount',
    'pendingFamilyCallsCount',
  ];
  const decimals = [
    'staffAttendance',
    'fallRate',
    'overtimeHours',
    'trainingCompletionRate',
    'handHygieneAuditScore',
    'satisfactionRate',
    'profitMargin',
    'payrollRatio',
    'outstandingPayments',
  ];
  const strings = [
    'pswToResidentRatio',
    'ppeInventoryLevel',
    'outbreakStatus',
    'moodTrends',
  ];
  const lists = [
    'highRiskResidentsList',
    'staffWorkloadList',
    'revenueByService',
    'revenueByTherapist',
    'roomUtilization',
    'inventoryAlerts',
    'redFlags',
  ];
  for (final key in [...integers, ...decimals]) {
    final value = data[key];
    if (value is! num ||
        !value.isFinite ||
        (integers.contains(key) &&
            (value < 0 || value != value.truncateToDouble()))) {
      throw const FormatException('Invalid dashboard metric');
    }
  }
  for (final key in strings) {
    if (data[key] is! String || (data[key] as String).trim().isEmpty) {
      throw const FormatException('Invalid dashboard status');
    }
  }
  for (final key in lists) {
    final value = data[key];
    if (value is! List || value.any((row) => row is! Map<String, dynamic>)) {
      throw const FormatException('Invalid dashboard rows');
    }
  }
  const rowStrings = {
    'highRiskResidentsList': ['name', 'riskType', 'status'],
    'staffWorkloadList': ['name'],
    'revenueByService': ['service'],
    'inventoryAlerts': ['item', 'level'],
    'redFlags': ['level', 'message', 'type'],
  };
  const rowNumbers = {
    'staffWorkloadList': ['load', 'breaksSkipped'],
    'revenueByService': ['amount'],
  };
  for (final key in lists) {
    for (final row in data[key] as List) {
      for (final field in rowStrings[key] ?? <String>[]) {
        if (row[field] is! String || (row[field] as String).trim().isEmpty) {
          throw const FormatException('Invalid dashboard row text');
        }
      }
      for (final field in rowNumbers[key] ?? <String>[]) {
        final value = row[field];
        if (value is! num || !value.isFinite) {
          throw const FormatException('Invalid dashboard row number');
        }
      }
    }
  }

}

// --- Controller (Notifier) ---
class ClinicalDirectorDashboardController
    extends StateNotifier<ClinicalDirectorDashboardState> {
  final Future<ApiResponse> Function() _fetchMetrics;
  int _loadGeneration = 0;

  ClinicalDirectorDashboardController(Ref ref)
    : this.withLoader(
        () => ref.read(apiClientProvider).get('/v1/clinical/dashboard'),
      );

  ClinicalDirectorDashboardController.withLoader(this._fetchMetrics)
    : super(
        const ClinicalDirectorDashboardState(
          isLoading: false,
          title: 'Care Director Control Room',
          logs: [],
        ),
      ) {
    loadDashboardMetrics();
  }

  Future<void> loadDashboardMetrics() async {
    final generation = ++_loadGeneration;
    state = state.copyWith(
      isLoading: true,
      hasValidatedMetrics: false,
      clearError: true,
    );
    try {
      final response = await _fetchMetrics();
      if (!mounted || generation != _loadGeneration) return;
      if (response.isSuccess && response.data != null) {
        final payload = response.data;
        if (payload is! Map<String, dynamic>) {
          throw const FormatException('Invalid dashboard');
        }
        final d = payload.containsKey('data') ? payload['data'] : payload;
        _validateClinicalDashboard(d);
        state = state.copyWith(
          isLoading: false,
          hasValidatedMetrics: true,
          clearError: true,
          residentsToday: (d['residentsToday'] as num).toInt(),
          staffOnShift: (d['staffOnShift'] as num).toInt(),
          openShifts: (d['openShifts'] as num).toInt(),
          fallsToday: (d['fallsToday'] as num).toInt(),
          incidentsToday: (d['incidentsToday'] as num).toInt(),
          hospitalTransfers: (d['hospitalTransfers'] as num).toInt(),
          staffAttendance: (d['staffAttendance'] as num).toDouble(),
          activeOutbreaks: (d['activeOutbreaks'] as num).toInt(),

          fallRate: (d['fallRate'] as num).toDouble(),
          pressureUlcersCount: (d['pressureUlcersCount'] as num).toInt(),
          wanderingAlertsCount: (d['wanderingAlertsCount'] as num).toInt(),
          missedRepositioningsCount: (d['missedRepositioningsCount'] as num)
              .toInt(),
          weightLossRiskCount: (d['weightLossRiskCount'] as num).toInt(),
          dehydrationAlertCount: (d['dehydrationAlertCount'] as num).toInt(),

          highRiskResidentsList: List<Map<String, dynamic>>.from(
            (d['highRiskResidentsList'] as List).map(
              (e) => Map<String, dynamic>.from(e as Map),
            ),
          ),

          pswToResidentRatio: d['pswToResidentRatio'] as String,
          overtimeHours: (d['overtimeHours'] as num).toDouble(),
          sickCalls: (d['sickCalls'] as num).toInt(),
          agencyStaffUsage: (d['agencyStaffUsage'] as num).toInt(),
          trainingCompletionRate: (d['trainingCompletionRate'] as num)
              .toDouble(),
          expiringCertifications: (d['expiringCertifications'] as num).toInt(),

          staffWorkloadList: List<Map<String, dynamic>>.from(
            (d['staffWorkloadList'] as List).map(
              (e) => Map<String, dynamic>.from(e as Map),
            ),
          ),

          missingADLChartingCount: (d['missingADLChartingCount'] as num)
              .toInt(),
          lateIncidentReportsCount: (d['lateIncidentReportsCount'] as num)
              .toInt(),
          overdueCarePlansCount: (d['overdueCarePlansCount'] as num).toInt(),
          privacyBreachCount: (d['privacyBreachCount'] as num).toInt(),
          activeAbuseInvestigationsCount:
              (d['activeAbuseInvestigationsCount'] as num).toInt(),

          activeInfectionsCount: (d['activeInfectionsCount'] as num).toInt(),
          isolationCount: (d['isolationCount'] as num).toInt(),
          ppeInventoryLevel: d['ppeInventoryLevel'] as String,
          handHygieneAuditScore: (d['handHygieneAuditScore'] as num).toDouble(),
          outbreakStatus: d['outbreakStatus'] as String,

          activeComplaintsCount: (d['activeComplaintsCount'] as num).toInt(),
          satisfactionRate: (d['satisfactionRate'] as num).toDouble(),
          pendingFamilyCallsCount: (d['pendingFamilyCallsCount'] as num)
              .toInt(),
          moodTrends: d['moodTrends'] as String,

          profitMargin: (d['profitMargin'] as num).toDouble(),
          payrollRatio: (d['payrollRatio'] as num).toDouble(),
          outstandingPayments: (d['outstandingPayments'] as num).toDouble(),

          revenueByService: List<Map<String, dynamic>>.from(
            (d['revenueByService'] as List).map(
              (e) => Map<String, dynamic>.from(e as Map),
            ),
          ),
          revenueByTherapist: List<Map<String, dynamic>>.from(
            (d['revenueByTherapist'] as List).map(
              (e) => Map<String, dynamic>.from(e as Map),
            ),
          ),
          roomUtilization: List<Map<String, dynamic>>.from(
            (d['roomUtilization'] as List).map(
              (e) => Map<String, dynamic>.from(e as Map),
            ),
          ),
          inventoryAlerts: List<Map<String, dynamic>>.from(
            (d['inventoryAlerts'] as List).map(
              (e) => Map<String, dynamic>.from(e as Map),
            ),
          ),
          redFlags: List<Map<String, dynamic>>.from(
            (d['redFlags'] as List).map(
              (e) => Map<String, dynamic>.from(e as Map),
            ),
          ),
        );
      } else {
        _setUnavailable();
      }
    } catch (_) {
      if (!mounted || generation != _loadGeneration) return;
      _setUnavailable();
    }
  }

  void _setUnavailable() {
    state = state.copyWith(
      isLoading: false,
      hasValidatedMetrics: false,
      error: 'Clinical dashboard data is unavailable.',
    );
  }

  void _setActionUnavailable() {
    ++_loadGeneration;
    state = state.copyWith(isLoading: false, hasValidatedMetrics: false,
      error: 'Clinical dashboard actions are unavailable.');
  }

  void changeTab(int index) {
    state = state.copyWith(activeTab: index);
  }

  Future<void> runComplianceScan() async {
    _setActionUnavailable();
  }

  void syncPosture() {
    _setActionUnavailable();
  }

  void updatePolicy() {
    _setActionUnavailable();
  }

  void exportLogs() {
    _setActionUnavailable();
  }

  void addLog(String entry) {
    _setActionUnavailable();
  }

  void triggerEmergencyAlert({required String type, required String wing}) {
    _setActionUnavailable();
  }

  void submitIncident({
    required String resident,
    required String type,
    required String severity,
    required String details,
  }) {
    _setActionUnavailable();
  }

  void submitStaffCallOff({
    required String name,
    required String shift,
    required bool autoSuggest,
  }) {
    _setActionUnavailable();
  }

  void submitResidentLookup({required String query}) {
    _setActionUnavailable();
  }

  void resolveMissingCharting({required String description}) {
    _setActionUnavailable();
  }
}

// --- Provider ---
final clinicalDirectorDashboardProvider =
    StateNotifierProvider<
      ClinicalDirectorDashboardController,
      ClinicalDirectorDashboardState
    >((ref) {
      return ClinicalDirectorDashboardController(ref);
    });

// --- View ---
class ClinicalDirectorDashboardScreen extends GovernedConsumerWidget {
  const ClinicalDirectorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicalDirectorDashboardProvider);
    final controller = ref.read(clinicalDirectorDashboardProvider.notifier);
    final theme = context.theme;

    return Cy(
      id: 'clinicaldashboard-screen',
      child: Scaffold(
        key: const Key('clinicaldirectordashboard-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            container: true,
            label: 'data-cy:clinicaldashboard-title',
            child: Text(
              key: const Key('clinicaldirectordashboard-title'),
              state.title.tr(),
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
          actions: [
            IconButton(
              key: const Key('clinicaldirectordashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.loadDashboardMetrics(),
            ),
          ],
        ),
        body: !state.hasValidatedMetrics || state.isLoading
            ? Center(child: state.isLoading
                ? const CircularProgressIndicator(key: Key('clinical-dashboard-loading'))
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(state.error ?? 'Clinical dashboard data is unavailable.',
                      key: Key('clinical-dashboard-unavailable')),
                    TextButton(onPressed: controller.loadDashboardMetrics,
                      child: const Text('Retry')),
                  ]))
            : Cy(
          id: 'clinicaldashboard-content',
          child: ResponsiveSplitDashboard(
          metrics: [
            _buildExecMetricItem(context, title: 'Residents Census',
              value: '${state.residentsToday}', icon: LucideIcons.home),
            _buildExecMetricItem(context, title: 'Staff On Shift',
              value: '${state.staffOnShift} PSWs', icon: LucideIcons.userCheck),
            GovMetricCard(
              title: 'Active Outbreaks'.tr(),
              value: state.activeOutbreaks == 0 ? 'Clear'.tr() : '${state.activeOutbreaks}',
              trendLabel: state.activeOutbreaks == 0 ? 'Optimal' : 'Active Quarantine',
              progress: state.activeOutbreaks == 0 ? 1.0 : 0.0,
              icon: LucideIcons.shieldAlert,
              brandColor: state.activeOutbreaks == 0 ? const Color(0xFF16A34A) : const Color(0xFFB91C1C),
            ),
            GovMetricCard(
              title: 'Falls Today'.tr(),
              value: '${state.fallsToday}',
              trendLabel: state.fallsToday == 0 ? 'No falls' : 'Requires Review',
              progress: state.fallsToday == 0 ? 1.0 : 0.3,
              icon: LucideIcons.alertTriangle,
              brandColor: state.fallsToday == 0 ? const Color(0xFF16A34A) : const Color(0xFFEAB308),
            ),
          ],
          mainContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'data-cy:clinicaldirectordashboard-title',
                child: GovDashboardHero(
                  title: 'PSW Care Director Control Room'.tr(),
                  roleName: 'Care Director Dashboard',
                  description: 'Manage resident safety, staff shifts, government compliance checklist, family feedback, and infection control logs.'.tr(),
                  onRefresh: () => controller.loadDashboardMetrics(),
                ),
              ),
              const SizedBox(height: 24),
              GovQuickActionBar(controller: controller, state: state),
              const SizedBox(height: 24),
              // --- Scrollable Tab Selector ---
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTabButton(context, 0, '📊 Executive', state.activeTab == 0, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 1, '🛡️ Safety', state.activeTab == 1, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 2, '👥 Staffing', state.activeTab == 2, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 3, '📜 Compliance', state.activeTab == 3, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 4, '🧫 Outbreak', state.activeTab == 4, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 5, '⚠️ Incidents', state.activeTab == 5, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 6, '📞 Families', state.activeTab == 6, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 7, '💰 Financials', state.activeTab == 7, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 8, '📦 Inventory', state.activeTab == 8, controller),
                    const SizedBox(width: 8),
                    _buildTabButton(context, 9, '📈 Analytics', state.activeTab == 9, controller),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildActiveTabContent(context, state, controller),
              ),
            ],
          ),
          defaultSidebarWidgets: [
            // === Executive Action Button ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                key: const Key('clinicaldirectordashboard-btn-2'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primaryContainer,
                  foregroundColor: theme.colors.primary,
                  elevation: 0,
                  side: BorderSide(color: theme.colors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                icon: const Icon(LucideIcons.checkSquare, size: 18),
                onPressed: () => controller.syncPosture(),
                label: Text('Trigger Clinical Sync Sweep'.tr()),
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
                    'Operational Audit Logs'.tr(),
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
                      key: const Key('clinicaldirectordashboard-btn-3'),
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
                                key: Key('clinicaldirectordashboard-loading'),
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Incident Audit Scan'.tr(),
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
      ),
    );
  }

  Widget _buildTabButton(BuildContext context, int index, String label, bool isActive, ClinicalDirectorDashboardController controller) {
    final theme = context.theme;
    return InkWell(
      onTap: () => controller.changeTab(index),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.surface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isActive ? theme.colors.primary : theme.colors.border,
            width: 1.5,
          ),
          boxShadow: isActive ? [
            BoxShadow(
              color: theme.colors.primary.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Text(
          label.tr(),
          style: theme.typography.labelBold.copyWith(
            color: isActive ? Colors.white : theme.colors.onSurface,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTabContent(BuildContext context, ClinicalDirectorDashboardState state, ClinicalDirectorDashboardController controller) {
    switch (state.activeTab) {
      case 0:
        return _buildExecutiveTab(context, state);
      case 1:
        return _buildSafetyTab(context, state);
      case 2:
        return _buildStaffingTab(context, state);
      case 3:
        return _buildComplianceTab(context, state);
      case 4:
        return _buildInfectionTab(context, state);
      case 5:
        return _buildIncidentsTab(context, state);
      case 6:
        return _buildFamilyTab(context, state);
      case 7:
        return _buildFinancialTab(context, state);
      case 8:
        return _buildInventoryTab(context, state);
      case 9:
        return _buildAnalyticsTab(context, state);
      default:
        return const SizedBox.shrink();
    }
  }

  // --- 1. Executive Summary Tab ---
  Widget _buildExecutiveTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-exec'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Census & Operations Telemetry'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 8),
                Text(
                  'Monitors care census, staffing ratios, and immediate incidents today.'.tr(),
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildExecMetricItem(context, title: 'Residents Census', value: '${state.residentsToday}', icon: LucideIcons.home),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildExecMetricItem(context, title: 'PSWs On Shift', value: '${state.staffOnShift}', icon: LucideIcons.users),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildExecMetricItem(context, title: 'Open Staff Gaps', value: '${state.openShifts}', icon: LucideIcons.userPlus),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildExecMetricItem(context, title: 'Staff Attendance Rate', value: '${state.staffAttendance.toStringAsFixed(1)}%', icon: LucideIcons.checkSquare),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Resident safety telemetry is unavailable.'),
      ],
    );
  }

  Widget _buildExecMetricItem(BuildContext context, {required String title, required String value, required IconData icon}) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.background,
        borderRadius: BorderRadius.circular(theme.radiusSm),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                const SizedBox(height: 4),
                Text(value, style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. Resident Safety Tab ---
  Widget _buildSafetyTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-safety'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resident Clinical Safety Panel'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 24),
                _buildSafetyItem(context, title: 'Fall Rate (Per 1000 days)', value: '${state.fallRate.toStringAsFixed(1)}', status: state.fallRate > 1.5 ? 'Warning' : 'Optimal'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Pressure Ulcer Log (Stage 2+)', value: '${state.pressureUlcersCount}', status: state.pressureUlcersCount > 0 ? 'Warning' : 'Clear'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Repositionings Missed Today', value: '${state.missedRepositioningsCount}', status: state.missedRepositioningsCount > 0 ? 'Warning' : 'Clear'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Nutrition / Weight Loss Risks', value: '${state.weightLossRiskCount} residents', status: state.weightLossRiskCount > 2 ? 'Warning' : 'Clear'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High-Risk Resident Monitoring Logs'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.highRiskResidentsList.length,
                  separatorBuilder: (context, idx) => const Divider(),
                  itemBuilder: (context, idx) {
                    final resident = state.highRiskResidentsList[idx];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (resident['name'] as String? ?? '').tr(),
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (resident['riskType'] as String? ?? '').tr(),
                            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              (resident['status'] as String? ?? '').toUpperCase().tr(),
                              style: const TextStyle(color: Color(0xFFB91C1C), fontWeight: FontWeight.bold, fontSize: 9),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSafetyItem(BuildContext context, {required String title, required String value, required String status}) {
    final theme = context.theme;
    final isWarning = status == 'Warning';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.tr(), style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(isWarning ? 'Requires clinical intervention'.tr() : 'Within safe operating bounds'.tr(),
                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
          ],
        ),
        Row(
          children: [
            Text(value, style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isWarning ? const Color(0xFFFEF3C7) : const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                status.toUpperCase().tr(),
                style: TextStyle(
                  color: isWarning ? const Color(0xFFB45309) : const Color(0xFF15803D),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- 3. Staffing Tab ---
  Widget _buildStaffingTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-staffing'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildExecMetricItem(context, title: 'PSW Ratio', value: state.pswToResidentRatio, icon: LucideIcons.users),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildExecMetricItem(context, title: 'Overtime Hours', value: '${state.overtimeHours}h', icon: LucideIcons.clock),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildExecMetricItem(context, title: 'Training Rate', value: '${state.trainingCompletionRate}%', icon: LucideIcons.checkCircle2),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PSW Schedule Load & Fatigue Warnings'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.staffWorkloadList.length,
                  separatorBuilder: (context, idx) => const Divider(height: 24),
                  itemBuilder: (context, idx) {
                    final item = state.staffWorkloadList[idx];
                    final load = (item['load'] as num? ?? 0).toDouble();
                    final breaks = (item['breaksSkipped'] as num? ?? 0).toInt();
                    final name = item['name'] as String? ?? '';
                    final isOverload = load >= 90.0 || breaks > 0;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(name.tr(), style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
                            Text('${load.toStringAsFixed(0)}% workload', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: LinearProgressIndicator(
                            value: load / 100.0,
                            backgroundColor: theme.colors.border,
                            color: isOverload ? const Color(0xFFB91C1C) : theme.colors.primary,
                            minHeight: 8,
                          ),
                        ),
                        if (isOverload) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(LucideIcons.alertTriangle, color: Color(0xFFB91C1C), size: 14),
                              const SizedBox(width: 6),
                              Text('Burnout warning: High schedule load or missed breaks.'.tr(), style: const TextStyle(color: Color(0xFFB91C1C), fontSize: 11)),
                            ],
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 4. Compliance Tab ---
  Widget _buildComplianceTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-compliance'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ministry & Care Guidelines Compliance'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 24),
                _buildSafetyItem(context, title: 'Missing ADL Charting Log', value: '${state.missingADLChartingCount}', status: state.missingADLChartingCount > 0 ? 'Warning' : 'Optimal'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Late Incident Submissions', value: '${state.lateIncidentReportsCount}', status: state.lateIncidentReportsCount > 0 ? 'Warning' : 'Clear'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Overdue Care Plan Reviews', value: '${state.overdueCarePlansCount}', status: state.overdueCarePlansCount > 0 ? 'Warning' : 'Clear'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Active Abuse Investigations', value: '${state.activeAbuseInvestigationsCount}', status: state.activeAbuseInvestigationsCount > 0 ? 'Critical' : 'Clear'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 5. Infection Control Tab ---
  Widget _buildInfectionTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-infection'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Infection Control & Outbreak Status'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 24),
                _buildSafetyItem(context, title: 'Active Infections', value: '${state.activeInfectionsCount} cases', status: state.activeInfectionsCount > 2 ? 'Warning' : 'Clear'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Residents In Isolation', value: '${state.isolationCount}', status: state.isolationCount > 0 ? 'Warning' : 'Clear'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'PPE Stock Level', value: state.ppeInventoryLevel, status: state.ppeInventoryLevel.toLowerCase().contains('low') ? 'Warning' : 'Optimal'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Hand Hygiene Compliance Rate', value: '${state.handHygieneAuditScore}%', status: state.handHygieneAuditScore < 90.0 ? 'Warning' : 'Optimal'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 6. Incidents Tab ---
  Widget _buildIncidentsTab(BuildContext context, ClinicalDirectorDashboardState state) {
    return Column(
      key: const ValueKey('tab-incidents'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Care incident records are unavailable.'),
      ],
    );
  }

  // --- 7. Family Communication Tab ---
  Widget _buildFamilyTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-family'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Family Relations & Feedback Panel'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 24),
                _buildSafetyItem(context, title: 'Family Complaints Pending', value: '${state.activeComplaintsCount}', status: state.activeComplaintsCount > 0 ? 'Warning' : 'Optimal'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Escalated Issues Inbound', value: '${state.pendingFamilyCallsCount}', status: state.pendingFamilyCallsCount > 1 ? 'Warning' : 'Optimal'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Overall Satisfaction Level', value: '${state.satisfactionRate}%', status: state.satisfactionRate < 90.0 ? 'Warning' : 'Optimal'),
                const Divider(height: 24),
                _buildSafetyItem(context, title: 'Resident Mood Indicator', value: state.moodTrends.tr(), status: 'Optimal'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 8. Financials Tab ---
  Widget _buildFinancialTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-financial'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildFinancialSummaryCard(context, title: 'Operating Margin', value: '${state.profitMargin.toStringAsFixed(1)}%', icon: LucideIcons.percent, color: const Color(0xFF16A34A)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFinancialSummaryCard(context, title: 'Payroll / Cost Index', value: '${state.payrollRatio.toStringAsFixed(1)}%', icon: LucideIcons.calculator, color: theme.colors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFinancialSummaryCard(context, title: 'Outstanding Claims', value: '\$${state.outstandingPayments.toStringAsFixed(2)}', icon: LucideIcons.receipt, color: const Color(0xFFEAB308)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Operations Revenue Breakdown'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.revenueByService.length,
                  separatorBuilder: (context, idx) => const Divider(),
                  itemBuilder: (context, idx) {
                    final item = state.revenueByService[idx];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text((item['service'] as String? ?? '').tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
                          Text('\$${(item['amount'] as num? ?? 0).toDouble().toStringAsFixed(2)}', style: theme.typography.bodyLarge.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialSummaryCard(BuildContext context, {required String title, required String value, required IconData icon, required Color color}) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: theme.typography.h2.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- 9. Inventory Tab ---
  Widget _buildInventoryTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-inventory'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Critical Supply Stock Levels'.tr(),
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 16),
                ...state.inventoryAlerts.map((item) {
                  final name = item['item'] as String? ?? '';
                  final level = item['level'] as String? ?? '';
                  final isLow = level.toLowerCase().contains('low');

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isLow ? const Color(0xFFFEF3C7) : theme.colors.background,
                        borderRadius: BorderRadius.circular(theme.radiusSm),
                        border: Border.all(color: isLow ? const Color(0xFFFDE68A) : theme.colors.border),
                      ),
                      child: Row(
                        children: [
                          Icon(isLow ? LucideIcons.alertTriangle : LucideIcons.packageCheck, color: isLow ? const Color(0xFFB45309) : const Color(0xFF15803D), size: 20),
                          const SizedBox(width: 12),
                          Expanded(child: Text(name.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold))),
                          Text(level.tr(), style: theme.typography.bodySmall.copyWith(color: isLow ? const Color(0xFFB45309) : const Color(0xFF15803D), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 10. Analytics Tab ---
  Widget _buildAnalyticsTab(BuildContext context, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    return Column(
      key: const ValueKey('tab-analytics'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 0,
          color: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(theme.radiusMd),
            side: BorderSide(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abuse & Neglect Risk HUD (Red Flags)'.tr(),
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 8),
                Text(
                  'Critical warnings requiring immediate intervention or safety review.'.tr(),
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                ...state.redFlags.map((flag) {
                  final level = flag['level'] as String? ?? 'info';
                  final message = flag['message'] as String? ?? '';
                  final type = flag['type'] as String? ?? '';

                  Color tintColor = const Color(0xFF2563EB);
                  Color bgTint = const Color(0xFFEFF6FF);
                  Color borderTint = const Color(0xFFBFDBFE);
                  IconData icon = LucideIcons.info;

                  if (level == 'danger') {
                    tintColor = const Color(0xFFB91C1C);
                    bgTint = const Color(0xFFFEE2E2);
                    borderTint = const Color(0xFFFECACA);
                    icon = LucideIcons.xCircle;
                  } else if (level == 'warning') {
                    tintColor = const Color(0xFFB45309);
                    bgTint = const Color(0xFFFEF3C7);
                    borderTint = const Color(0xFFFDE68A);
                    icon = LucideIcons.alertTriangle;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: bgTint,
                        borderRadius: BorderRadius.circular(theme.radiusSm),
                        border: Border.all(color: borderTint, width: 1.5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(icon, color: tintColor, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(type.toUpperCase().tr(), style: TextStyle(color: tintColor, fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 1.0)),
                                const SizedBox(height: 4),
                                Text(message.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GovQuickActionBar extends StatefulWidget {
  final ClinicalDirectorDashboardController controller;
  final ClinicalDirectorDashboardState state;

  const GovQuickActionBar({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  State<GovQuickActionBar> createState() => _GovQuickActionBarState();
}

class _GovQuickActionBarState extends State<GovQuickActionBar> {
  int _selectedCategory = 0; // 0: Emergency, 1: Staffing, 2: Resident, 3: Compliance, 4: Operations

  void _showEmergencyDialog(BuildContext context, ClinicalDirectorDashboardController controller) {
    final theme = context.theme;
    String selectedCode = 'Code Blue - Medical Alert';
    String selectedWing = 'Memory Care Unit';

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: theme.colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radiusMd)),
              title: Row(
                children: [
                  const Icon(LucideIcons.alertTriangle, color: Color(0xFFDC2626), size: 28),
                  const SizedBox(width: 10),
                  Text('Trigger Safety Code'.tr(), style: theme.typography.h3.copyWith(color: theme.colors.onSurface)),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select safety code and facility area to broadcast alert.'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  Text('Emergency Code'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    dropdownColor: theme.colors.surface,
                    value: selectedCode,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.colors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: theme.colors.border)),
                    ),
                    items: <String>[
                      'Code Blue - Medical Alert',
                      'Code White - Resident Aggression',
                      'Code Yellow - Missing Resident',
                      'Call 911 Distress Log',
                      'Abuse Concern Review Alert'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedCode = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Assigned Wing / Location'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    dropdownColor: theme.colors.surface,
                    value: selectedWing,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.colors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: theme.colors.border)),
                    ),
                    items: <String>[
                      'Memory Care Unit',
                      'East Wing (Retirement)',
                      'West Wing (Assisted Living)',
                      'South Wing (Long-Term Care)',
                      'Facility-Wide Broadcast'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedWing = val);
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Cancel'.tr(), style: TextStyle(color: theme.colors.onSurfaceVariant)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    controller.triggerEmergencyAlert(type: selectedCode, wing: selectedWing);
                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFFDC2626),
                        content: Text('Clinical dashboard actions are unavailable.'.tr()),
                      ),
                    );
                  },
                  child: Text('Broadcast Alert'.tr()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showNewIncidentDialog(BuildContext context, ClinicalDirectorDashboardController controller) {
    final theme = context.theme;
    final residentController = TextEditingController();
    final detailsController = TextEditingController(text: 'Resident experienced minor loss of balance in common room.');
    String selectedType = 'Resident Fall';
    String selectedSeverity = 'Critical';

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: theme.colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radiusMd)),
              title: Row(
                children: [
                  const Icon(LucideIcons.fileSpreadsheet, color: Color(0xFFDC2626), size: 28),
                  const SizedBox(width: 10),
                  Text('Report New Incident'.tr(), style: theme.typography.h3.copyWith(color: theme.colors.onSurface)),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Log fall, injury, or abuse concerns directly to compliance database.'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                    const SizedBox(height: 16),
                    Text('Resident Name'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: residentController,
                      style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.colors.background,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Incident Type'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      dropdownColor: theme.colors.surface,
                      value: selectedType,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.colors.background,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      items: <String>[
                        'Resident Fall',
                        'Resident Wandering Alert',
                        'Injury of Unknown Origin',
                        'Abuse / Harassment Allegation',
                        'Medication Refusal / Issue',
                        'Infection Outbreak Case',
                        'Hospital Emergency Transfer'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => selectedType = val);
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Severity Level'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      dropdownColor: theme.colors.surface,
                      value: selectedSeverity,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.colors.background,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      items: <String>['Low', 'Medium', 'Critical', 'Danger'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => selectedSeverity = val);
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Incident Details / Comments'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: detailsController,
                      style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                      maxLines: 3,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.colors.background,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Cancel'.tr(), style: TextStyle(color: theme.colors.onSurfaceVariant)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    controller.submitIncident(
                      resident: residentController.text,
                      type: selectedType,
                      severity: selectedSeverity,
                      details: detailsController.text,
                    );
                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: theme.colors.primary,
                        content: Text('Clinical dashboard actions are unavailable.'.tr()),
                      ),
                    );
                  },
                  child: Text('Submit Report'.tr()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showStaffCallOffDialog(BuildContext context, ClinicalDirectorDashboardController controller) {
    final theme = context.theme;
    final staffController = TextEditingController();
    String selectedShift = 'Day Shift (07:00 - 15:00)';
    bool autoSuggest = true;

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: theme.colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radiusMd)),
              title: Row(
                children: [
                  const Icon(LucideIcons.userMinus, color: Color(0xFF2563EB), size: 28),
                  const SizedBox(width: 10),
                  Text('Register Staff Call-Off'.tr(), style: theme.typography.h3.copyWith(color: theme.colors.onSurface)),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Log sudden sickness calls or shift call-offs to adjust live coverage levels.'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  Text('Absent Staff Name'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: staffController,
                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.colors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Assigned Shift'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    dropdownColor: theme.colors.surface,
                    value: selectedShift,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.colors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    items: <String>[
                      'Day Shift (07:00 - 15:00)',
                      'Evening Shift (15:00 - 23:00)',
                      'Night Shift (23:00 - 07:00)'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedShift = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    title: Text('Find Available Replacement PSWs'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface)),
                    subtitle: Text('Leverage smart scheduling to ping available staff on standby.'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                    value: autoSuggest,
                    activeColor: theme.colors.primary,
                    onChanged: (val) {
                      if (val != null) setState(() => autoSuggest = val);
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Cancel'.tr(), style: TextStyle(color: theme.colors.onSurfaceVariant)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    controller.submitStaffCallOff(
                      name: staffController.text,
                      shift: selectedShift,
                      autoSuggest: autoSuggest,
                    );
                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF2563EB),
                        content: Text('Clinical dashboard actions are unavailable.'.tr()),
                      ),
                    );
                  },
                  child: Text('Register Absentee'.tr()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showResidentLookupDialog(BuildContext context, ClinicalDirectorDashboardController controller, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    final searchController = TextEditingController();
    List<Map<String, dynamic>> filteredResidents = List.from(state.highRiskResidentsList);

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: theme.colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radiusMd)),
              title: Row(
                children: [
                  const Icon(LucideIcons.search, color: Color(0xFF16A34A), size: 28),
                  const SizedBox(width: 10),
                  Text('Resident Search Station'.tr(), style: theme.typography.h3.copyWith(color: theme.colors.onSurface)),
                ],
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Look up resident charts, fall parameters, and daily ADL checklists.'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: searchController,
                      style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                      decoration: InputDecoration(
                        hintText: 'Type name to search...'.tr(),
                        prefixIcon: const Icon(LucideIcons.search),
                        filled: true,
                        fillColor: theme.colors.background,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (val) {
                        setState(() {
                          filteredResidents = state.highRiskResidentsList
                              .where((res) => (res['name'] as String).toLowerCase().contains(val.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Active Care Rosters'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.colors.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: filteredResidents.isEmpty ? 1 : filteredResidents.length,
                        separatorBuilder: (context, idx) => const Divider(height: 1),
                        itemBuilder: (context, idx) {
                          if (filteredResidents.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('No residents match query.'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                            );
                          }
                          final res = filteredResidents[idx];
                          return ListTile(
                            title: Text(res['name'] as String, style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
                            subtitle: Text('${res['riskType']} • ${res['status']}'.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                            trailing: Icon(LucideIcons.chevronRight, size: 16, color: theme.colors.primary),
                            onTap: () {
                              controller.submitResidentLookup(query: res['name'] as String);
                              Navigator.pop(dialogContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color(0xFF16A34A),
                                  content: Text('Clinical dashboard actions are unavailable.'.tr()),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Close'.tr(), style: TextStyle(color: theme.colors.onSurfaceVariant)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMissingChartingDialog(BuildContext context, ClinicalDirectorDashboardController controller, ClinicalDirectorDashboardState state) {
    final theme = context.theme;
    final List<Map<String, String>> outstandingLogs = [];

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: theme.colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radiusMd)),
              title: Row(
                children: [
                  const Icon(LucideIcons.clipboardList, color: Color(0xFFEA580C), size: 28),
                  const SizedBox(width: 10),
                  Text('Missing Documentation Hub'.tr(), style: theme.typography.h3.copyWith(color: theme.colors.onSurface)),
                ],
              ),
              content: SizedBox(
                width: 450,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Outstanding ADL tasks require validation for Ministry standard compliance.'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                    const SizedBox(height: 16),
                    Text('Missing Records Checklist (${state.missingADLChartingCount} remaining)'.tr(), style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface)),
                    const SizedBox(height: 8),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 250),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.colors.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: outstandingLogs.length,
                        separatorBuilder: (context, idx) => const Divider(height: 1),
                        itemBuilder: (context, idx) {
                          final log = outstandingLogs[idx];
                          return ListTile(
                            title: Text(log['patient']!, style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold)),
                            subtitle: Text(log['task']!.tr(), style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEA580C),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: () {
                                controller.resolveMissingCharting(description: '${log['task']} for ${log['patient']}');
                                setState(() {

                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color(0xFFEA580C),
                                    content: Text('ADL task signed and synchronized!'.tr()),
                                  ),
                                );
                              },
                              child: Text('Sign off'.tr(), style: const TextStyle(fontSize: 12)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Close'.tr(), style: TextStyle(color: theme.colors.onSurfaceVariant)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Category configs
    final List<Map<String, dynamic>> categories = [
      {
        'label': 'Emergency',
        'icon': LucideIcons.alertTriangle,
        'color': const Color(0xFFDC2626),
        'bg': const Color(0xFFFEE2E2),
        'border': const Color(0xFFFCA5A5),
      },
      {
        'label': 'Staffing',
        'icon': LucideIcons.users,
        'color': const Color(0xFF2563EB),
        'bg': const Color(0xFFDBEAFE),
        'border': const Color(0xFF93C5FD),
      },
      {
        'label': 'Resident',
        'icon': LucideIcons.heart,
        'color': const Color(0xFF16A34A),
        'bg': const Color(0xFFDCFCE7),
        'border': const Color(0xFF86EFAC),
      },
      {
        'label': 'Compliance',
        'icon': LucideIcons.clipboardList,
        'color': const Color(0xFFEA580C),
        'bg': const Color(0xFFFFEDD5),
        'border': const Color(0xFFFDBA74),
      },
      {
        'label': 'Operations',
        'icon': LucideIcons.cog,
        'color': const Color(0xFF4B5563),
        'bg': const Color(0xFFF3F4F6),
        'border': const Color(0xFFD1D5DB),
      },
    ];

    // Actions configs for each category
    final List<List<Map<String, dynamic>>> actionGroups = [
      // Emergency Actions
      [
        {
          'label': 'Emergency Alert',
          'icon': LucideIcons.phoneCall,
          'action': () => widget.controller.triggerEmergencyAlert(type: 'Code Blue - Medical Alert', wing: 'Memory Care Unit'),
        },
        {
          'label': 'New Incident',
          'icon': LucideIcons.fileSpreadsheet,
          'action': null,
        },
        {
          'label': 'Abuse Concern',
          'icon': LucideIcons.shieldAlert,
          'action': () => widget.controller.submitIncident(resident: 'Audit Board', type: 'Abuse Allegation Audit', severity: 'Critical', details: 'Immediate supervisor review required.'),
        },
        {
          'label': 'Missing Resident',
          'icon': LucideIcons.footprints,
          'action': () => widget.controller.triggerEmergencyAlert(type: 'Code Yellow - Missing Resident', wing: 'East Wing'),
        },
        {
          'label': 'Call 911 Log',
          'icon': LucideIcons.phone,
          'action': () => widget.controller.addLog('Log created: 911 emergency services contacted for medical transfer.'),
        },
      ],
      // Staffing Actions
      [
        {
          'label': 'Staff Call-Off',
          'icon': LucideIcons.userMinus,
          'action': null,
        },
        {
          'label': 'Open Shift',
          'icon': LucideIcons.calendarPlus,
          'action': () => widget.controller.addLog('Open Shift posted to agency pool for weekend coverage.'),
        },
        {
          'label': 'Find Available PSW',
          'icon': LucideIcons.userCheck,
          'action': () => widget.controller.addLog('AI search executed: identified 3 off-duty PSWs with matching credentials.'),
        },
        {
          'label': 'Shift Swap',
          'icon': LucideIcons.refreshCw,
          'action': () => widget.controller.addLog('Shift swap request approved for Memory Care unit team leads.'),
        },
        {
          'label': 'Overtime Approval',
          'icon': LucideIcons.dollarSign,
          'action': () => widget.controller.addLog('Overtime approved for Sarah Connor (PSW) to complete documentation sweep.'),
        },
      ],
      // Resident Actions
      [
        {
          'label': 'Resident Lookup',
          'icon': LucideIcons.search,
          'action': null,
        },
        {
          'label': 'Add Care Note',
          'icon': LucideIcons.fileText,
          'action': () => widget.controller.addLog('Direct care note posted to resident John Smith\'s chart.'),
        },
        {
          'label': 'Transfer Request',
          'icon': LucideIcons.arrowLeftRight,
          'action': () => widget.controller.addLog('Resident room transfer requested from East Wing to Memory Care.'),
        },
        {
          'label': 'Care Escalation',
          'icon': LucideIcons.trendingUp,
          'action': () => widget.controller.addLog('Care escalation triggered: care plan review scheduled with RPN supervisor.'),
        },
        {
          'label': 'Family Update',
          'icon': LucideIcons.phoneOutgoing,
          'action': () => widget.controller.addLog('Family outreach logged: updated John Smith\'s family regarding fall assessment.'),
        },
      ],
      // Compliance Actions
      [
        {
          'label': 'Missing Charting',
          'icon': LucideIcons.clipboardList,
          'action': null,
        },
        {
          'label': 'Incident Audit',
          'icon': LucideIcons.checkSquare,
          'action': () => widget.controller.runComplianceScan(),
        },
        {
          'label': 'Infection Audit',
          'icon': LucideIcons.shieldCheck,
          'action': () => widget.controller.addLog('Infection audit sweep: validated hand-hygiene records in West Wing.'),
        },
        {
          'label': 'Expired Certs',
          'icon': LucideIcons.award,
          'action': () => widget.controller.addLog('Credential review: flagged 2 expiring CPR certifications for staff reminder.'),
        },
        {
          'label': 'PHIPA Alert',
          'icon': LucideIcons.lock,
          'action': () => widget.controller.addLog('PHIPA warning: cleared active session timeout limits on administrative terminal.'),
        },
      ],
      // Operations Actions
      [
        {
          'label': 'PPE Inventory',
          'icon': LucideIcons.box,
          'action': () => widget.controller.addLog('PPE check: counts validated, 30-day stock level secured.'),
        },
        {
          'label': 'Laundry Status',
          'icon': LucideIcons.shirt,
          'action': () => widget.controller.addLog('Laundry service audit: East Wing resident clothing batch complete.'),
        },
        {
          'label': 'Maintenance Request',
          'icon': LucideIcons.wrench,
          'action': () => widget.controller.addLog('Work order submitted: repair call for room 204 grab bar loose.'),
        },
        {
          'label': 'Meal Service Issue',
          'icon': LucideIcons.utensils,
          'action': () => widget.controller.addLog('Dietary request: logged pureed meal alternative requirements for lunch shift.'),
        },
        {
          'label': 'Transport Request',
          'icon': LucideIcons.bus,
          'action': () => widget.controller.addLog('Transportation log: booked clinic shuttle for hospital follow-up check-in.'),
        },
      ],
    ];

    final activeCategory = categories[_selectedCategory];
    final activeActions = actionGroups[_selectedCategory];

    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Care Director Quick Action Bar'.tr(),
                style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: activeCategory['bg'] as Color,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: activeCategory['border'] as Color),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(activeCategory['icon'] as IconData, size: 12, color: activeCategory['color'] as Color),
                    const SizedBox(width: 4),
                    Text(
                      (activeCategory['label'] as String).tr(),
                      style: theme.typography.labelBold.copyWith(color: activeCategory['color'] as Color, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Category Tab Selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (idx) {
                final cat = categories[idx];
                final isSelected = _selectedCategory == idx;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () => setState(() => _selectedCategory = idx),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? cat['bg'] as Color : theme.colors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? cat['border'] as Color : theme.colors.border,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(cat['icon'] as IconData, size: 14, color: isSelected ? cat['color'] as Color : theme.colors.onSurfaceVariant),
                          const SizedBox(width: 6),
                          Text(
                            (cat['label'] as String).tr(),
                            style: theme.typography.bodySmall.copyWith(
                              color: isSelected ? cat['color'] as Color : theme.colors.onSurfaceVariant,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 18),

          // Action Buttons Wrap Grid
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: activeActions.map((act) {
              final label = act['label'] as String;
              final icon = act['icon'] as IconData;
              final action = act['action'] as void Function()?;

              // Check if button corresponds to one of the top 5 with custom interactive popups
              final bool isEmergencyDialog = label == 'Emergency Alert';
              final bool isIncidentDialog = label == 'New Incident';
              final bool isCallOffDialog = label == 'Staff Call-Off';
              final bool isLookupDialog = label == 'Resident Lookup';
              final bool isChartingDialog = label == 'Missing Charting';

              final bool hasCustomDialog = isEmergencyDialog || isIncidentDialog || isCallOffDialog || isLookupDialog || isChartingDialog;

              return InkWell(
                onTap: () {
                  if (hasCustomDialog) {
                    if (isEmergencyDialog) {
                      _showEmergencyDialog(context, widget.controller);
                    } else if (isIncidentDialog) {
                      _showNewIncidentDialog(context, widget.controller);
                    } else if (isCallOffDialog) {
                      _showStaffCallOffDialog(context, widget.controller);
                    } else if (isLookupDialog) {
                      _showResidentLookupDialog(context, widget.controller, widget.state);
                    } else if (isChartingDialog) {
                      _showMissingChartingDialog(context, widget.controller, widget.state);
                    }
                  } else {
                    if (action != null) {
                      action();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: activeCategory['color'] as Color,
                          content: Text('Clinical dashboard actions are unavailable.'.tr()),
                        ),
                      );
                    }
                  }
                },
                borderRadius: BorderRadius.circular(theme.radiusMd),
                child: Container(
                  width: 156,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.colors.background,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 24, color: activeCategory['color'] as Color),
                      const SizedBox(height: 8),
                      Text(
                        label.tr(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.typography.bodySmall.copyWith(
                          color: theme.colors.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
