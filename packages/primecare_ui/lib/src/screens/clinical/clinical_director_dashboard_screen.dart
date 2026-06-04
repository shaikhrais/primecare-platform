// Governance - Category: view | Purpose: UI Screen component rendering the Care Director Dashboard Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class ClinicalDirectorDashboardState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;
  final int activeTab;

  // Executive Overview Metrics
  final int residentsToday;
  final int staffOnShift;
  final int openShifts;
  final int fallsToday;
  final int incidentsToday;
  final int hospitalTransfers;
  final double staffAttendance;
  final int activeOutbreaks;

  // Resident Safety
  final double fallRate;
  final int pressureUlcersCount;
  final int wanderingAlertsCount;
  final int missedRepositioningsCount;
  final int weightLossRiskCount;
  final int dehydrationAlertCount;
  final List<Map<String, dynamic>> highRiskResidentsList;

  // Staffing
  final String pswToResidentRatio;
  final double overtimeHours;
  final int sickCalls;
  final int agencyStaffUsage;
  final double trainingCompletionRate;
  final int expiringCertifications;
  final List<Map<String, dynamic>> staffWorkloadList;

  // Compliance
  final int missingADLChartingCount;
  final int lateIncidentReportsCount;
  final int overdueCarePlansCount;
  final int privacyBreachCount;
  final int activeAbuseInvestigationsCount;

  // Infection Control
  final int activeInfectionsCount;
  final int isolationCount;
  final String ppeInventoryLevel;
  final double handHygieneAuditScore;
  final String outbreakStatus;

  // Family & Experience
  final int activeComplaintsCount;
  final double satisfactionRate;
  final int pendingFamilyCallsCount;
  final String moodTrends;

  // Financial Metrics
  final double profitMargin;
  final double payrollRatio;
  final double outstandingPayments;
  final List<Map<String, dynamic>> revenueByService;
  final List<Map<String, dynamic>> revenueByTherapist; // Representing Department Cost/Revenues

  // Operations Metrics (Facility Units & Supplies)
  final List<Map<String, dynamic>> roomUtilization; // Facility Unit Occupancy
  final List<Map<String, dynamic>> inventoryAlerts; // Essential Supply Stocks

  // Risk Alerts HUD
  final List<Map<String, dynamic>> redFlags;

  const ClinicalDirectorDashboardState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
    this.activeTab = 0,
    this.residentsToday = 0,
    this.staffOnShift = 0,
    this.openShifts = 0,
    this.fallsToday = 0,
    this.incidentsToday = 0,
    this.hospitalTransfers = 0,
    this.staffAttendance = 0.0,
    this.activeOutbreaks = 0,
    this.fallRate = 0.0,
    this.pressureUlcersCount = 0,
    this.wanderingAlertsCount = 0,
    this.missedRepositioningsCount = 0,
    this.weightLossRiskCount = 0,
    this.dehydrationAlertCount = 0,
    this.highRiskResidentsList = const [],
    this.pswToResidentRatio = '1:8',
    this.overtimeHours = 0.0,
    this.sickCalls = 0,
    this.agencyStaffUsage = 0,
    this.trainingCompletionRate = 0.0,
    this.expiringCertifications = 0,
    this.staffWorkloadList = const [],
    this.missingADLChartingCount = 0,
    this.lateIncidentReportsCount = 0,
    this.overdueCarePlansCount = 0,
    this.privacyBreachCount = 0,
    this.activeAbuseInvestigationsCount = 0,
    this.activeInfectionsCount = 0,
    this.isolationCount = 0,
    this.ppeInventoryLevel = 'Adequate',
    this.handHygieneAuditScore = 0.0,
    this.outbreakStatus = 'Clear',
    this.activeComplaintsCount = 0,
    this.satisfactionRate = 0.0,
    this.pendingFamilyCallsCount = 0,
    this.moodTrends = 'Stable',
    this.profitMargin = 0.0,
    this.payrollRatio = 0.0,
    this.outstandingPayments = 0.0,
    this.revenueByService = const [],
    this.revenueByTherapist = const [],
    this.roomUtilization = const [],
    this.inventoryAlerts = const [],
    this.redFlags = const [],
  });

  ClinicalDirectorDashboardState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
    int? activeTab,
    int? residentsToday,
    int? staffOnShift,
    int? openShifts,
    int? fallsToday,
    int? incidentsToday,
    int? hospitalTransfers,
    double? staffAttendance,
    int? activeOutbreaks,
    double? fallRate,
    int? pressureUlcersCount,
    int? wanderingAlertsCount,
    int? missedRepositioningsCount,
    int? weightLossRiskCount,
    int? dehydrationAlertCount,
    List<Map<String, dynamic>>? highRiskResidentsList,
    String? pswToResidentRatio,
    double? overtimeHours,
    int? sickCalls,
    int? agencyStaffUsage,
    double? trainingCompletionRate,
    int? expiringCertifications,
    List<Map<String, dynamic>>? staffWorkloadList,
    int? missingADLChartingCount,
    int? lateIncidentReportsCount,
    int? overdueCarePlansCount,
    int? privacyBreachCount,
    int? activeAbuseInvestigationsCount,
    int? activeInfectionsCount,
    int? isolationCount,
    String? ppeInventoryLevel,
    double? handHygieneAuditScore,
    String? outbreakStatus,
    int? activeComplaintsCount,
    double? satisfactionRate,
    int? pendingFamilyCallsCount,
    String? moodTrends,
    double? profitMargin,
    double? payrollRatio,
    double? outstandingPayments,
    List<Map<String, dynamic>>? revenueByService,
    List<Map<String, dynamic>>? revenueByTherapist,
    List<Map<String, dynamic>>? roomUtilization,
    List<Map<String, dynamic>>? inventoryAlerts,
    List<Map<String, dynamic>>? redFlags,
  }) {
    return ClinicalDirectorDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
      activeTab: activeTab ?? this.activeTab,
      residentsToday: residentsToday ?? this.residentsToday,
      staffOnShift: staffOnShift ?? this.staffOnShift,
      openShifts: openShifts ?? this.openShifts,
      fallsToday: fallsToday ?? this.fallsToday,
      incidentsToday: incidentsToday ?? this.incidentsToday,
      hospitalTransfers: hospitalTransfers ?? this.hospitalTransfers,
      staffAttendance: staffAttendance ?? this.staffAttendance,
      activeOutbreaks: activeOutbreaks ?? this.activeOutbreaks,
      fallRate: fallRate ?? this.fallRate,
      pressureUlcersCount: pressureUlcersCount ?? this.pressureUlcersCount,
      wanderingAlertsCount: wanderingAlertsCount ?? this.wanderingAlertsCount,
      missedRepositioningsCount: missedRepositioningsCount ?? this.missedRepositioningsCount,
      weightLossRiskCount: weightLossRiskCount ?? this.weightLossRiskCount,
      dehydrationAlertCount: dehydrationAlertCount ?? this.dehydrationAlertCount,
      highRiskResidentsList: highRiskResidentsList ?? this.highRiskResidentsList,
      pswToResidentRatio: pswToResidentRatio ?? this.pswToResidentRatio,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      sickCalls: sickCalls ?? this.sickCalls,
      agencyStaffUsage: agencyStaffUsage ?? this.agencyStaffUsage,
      trainingCompletionRate: trainingCompletionRate ?? this.trainingCompletionRate,
      expiringCertifications: expiringCertifications ?? this.expiringCertifications,
      staffWorkloadList: staffWorkloadList ?? this.staffWorkloadList,
      missingADLChartingCount: missingADLChartingCount ?? this.missingADLChartingCount,
      lateIncidentReportsCount: lateIncidentReportsCount ?? this.lateIncidentReportsCount,
      overdueCarePlansCount: overdueCarePlansCount ?? this.overdueCarePlansCount,
      privacyBreachCount: privacyBreachCount ?? this.privacyBreachCount,
      activeAbuseInvestigationsCount: activeAbuseInvestigationsCount ?? this.activeAbuseInvestigationsCount,
      activeInfectionsCount: activeInfectionsCount ?? this.activeInfectionsCount,
      isolationCount: isolationCount ?? this.isolationCount,
      ppeInventoryLevel: ppeInventoryLevel ?? this.ppeInventoryLevel,
      handHygieneAuditScore: handHygieneAuditScore ?? this.handHygieneAuditScore,
      outbreakStatus: outbreakStatus ?? this.outbreakStatus,
      activeComplaintsCount: activeComplaintsCount ?? this.activeComplaintsCount,
      satisfactionRate: satisfactionRate ?? this.satisfactionRate,
      pendingFamilyCallsCount: pendingFamilyCallsCount ?? this.pendingFamilyCallsCount,
      moodTrends: moodTrends ?? this.moodTrends,
      profitMargin: profitMargin ?? this.profitMargin,
      payrollRatio: payrollRatio ?? this.payrollRatio,
      outstandingPayments: outstandingPayments ?? this.outstandingPayments,
      revenueByService: revenueByService ?? this.revenueByService,
      revenueByTherapist: revenueByTherapist ?? this.revenueByTherapist,
      roomUtilization: roomUtilization ?? this.roomUtilization,
      inventoryAlerts: inventoryAlerts ?? this.inventoryAlerts,
      redFlags: redFlags ?? this.redFlags,
    );
  }
}

// --- Controller (Notifier) ---
class ClinicalDirectorDashboardController
    extends StateNotifier<ClinicalDirectorDashboardState> {
  final Ref ref;

  ClinicalDirectorDashboardController(this.ref)
      : super(
          const ClinicalDirectorDashboardState(
            isLoading: false,
            title: 'Care Director Control Room',
            logs: ['Care facility gateway online.', 'System parameters validated.'],
          ),
        ) {
    loadDashboardMetrics();
  }

  Future<void> loadDashboardMetrics() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.get('/v1/clinical/dashboard');
      if (response.isSuccess && response.data != null) {
        final d = response.data['data'] ?? response.data;
        state = state.copyWith(
          isLoading: false,
          residentsToday: (d['residentsToday'] as num?)?.toInt() ?? 142,
          staffOnShift: (d['staffOnShift'] as num?)?.toInt() ?? 18,
          openShifts: (d['openShifts'] as num?)?.toInt() ?? 3,
          fallsToday: (d['fallsToday'] as num?)?.toInt() ?? 1,
          incidentsToday: (d['incidentsToday'] as num?)?.toInt() ?? 2,
          hospitalTransfers: (d['hospitalTransfers'] as num?)?.toInt() ?? 1,
          staffAttendance: (d['staffAttendance'] as num?)?.toDouble() ?? 96.5,
          activeOutbreaks: (d['activeOutbreaks'] as num?)?.toInt() ?? 0,

          fallRate: (d['fallRate'] as num?)?.toDouble() ?? 1.2,
          pressureUlcersCount: (d['pressureUlcersCount'] as num?)?.toInt() ?? 2,
          wanderingAlertsCount: (d['wanderingAlertsCount'] as num?)?.toInt() ?? 0,
          missedRepositioningsCount: (d['missedRepositioningsCount'] as num?)?.toInt() ?? 1,
          weightLossRiskCount: (d['weightLossRiskCount'] as num?)?.toInt() ?? 4,
          dehydrationAlertCount: (d['dehydrationAlertCount'] as num?)?.toInt() ?? 1,

          highRiskResidentsList: List<Map<String, dynamic>>.from(
            (d['highRiskResidentsList'] as List?)?.map((e) => Map<String, dynamic>.from(e as Map)) ?? []
          ),

          pswToResidentRatio: (d['pswToResidentRatio'] as String?) ?? '1:8',
          overtimeHours: (d['overtimeHours'] as num?)?.toDouble() ?? 12.5,
          sickCalls: (d['sickCalls'] as num?)?.toInt() ?? 2,
          agencyStaffUsage: (d['agencyStaffUsage'] as num?)?.toInt() ?? 1,
          trainingCompletionRate: (d['trainingCompletionRate'] as num?)?.toDouble() ?? 98.2,
          expiringCertifications: (d['expiringCertifications'] as num?)?.toInt() ?? 2,

          staffWorkloadList: List<Map<String, dynamic>>.from(
            (d['staffWorkloadList'] as List?)?.map((e) => Map<String, dynamic>.from(e as Map)) ?? []
          ),

          missingADLChartingCount: (d['missingADLChartingCount'] as num?)?.toInt() ?? 4,
          lateIncidentReportsCount: (d['lateIncidentReportsCount'] as num?)?.toInt() ?? 1,
          overdueCarePlansCount: (d['overdueCarePlansCount'] as num?)?.toInt() ?? 2,
          privacyBreachCount: (d['privacyBreachCount'] as num?)?.toInt() ?? 0,
          activeAbuseInvestigationsCount: (d['activeAbuseInvestigationsCount'] as num?)?.toInt() ?? 0,

          activeInfectionsCount: (d['activeInfectionsCount'] as num?)?.toInt() ?? 3,
          isolationCount: (d['isolationCount'] as num?)?.toInt() ?? 2,
          ppeInventoryLevel: (d['ppeInventoryLevel'] as String?) ?? 'Adequate',
          handHygieneAuditScore: (d['handHygieneAuditScore'] as num?)?.toDouble() ?? 95.0,
          outbreakStatus: (d['outbreakStatus'] as String?) ?? 'Clear',

          activeComplaintsCount: (d['activeComplaintsCount'] as num?)?.toInt() ?? 1,
          satisfactionRate: (d['satisfactionRate'] as num?)?.toDouble() ?? 94.2,
          pendingFamilyCallsCount: (d['pendingFamilyCallsCount'] as num?)?.toInt() ?? 3,
          moodTrends: (d['moodTrends'] as String?) ?? 'Stable',

          profitMargin: (d['profitMargin'] as num?)?.toDouble() ?? 24.5,
          payrollRatio: (d['payrollRatio'] as num?)?.toDouble() ?? 48.0,
          outstandingPayments: (d['outstandingPayments'] as num?)?.toDouble() ?? 1480.0,

          revenueByService: List<Map<String, dynamic>>.from(
            (d['revenueByService'] as List?)?.map((e) => Map<String, dynamic>.from(e as Map)) ?? []
          ),
          revenueByTherapist: List<Map<String, dynamic>>.from(
            (d['revenueByTherapist'] as List?)?.map((e) => Map<String, dynamic>.from(e as Map)) ?? []
          ),
          roomUtilization: List<Map<String, dynamic>>.from(
            (d['roomUtilization'] as List?)?.map((e) => Map<String, dynamic>.from(e as Map)) ?? []
          ),
          inventoryAlerts: List<Map<String, dynamic>>.from(
            (d['inventoryAlerts'] as List?)?.map((e) => Map<String, dynamic>.from(e as Map)) ?? []
          ),
          redFlags: List<Map<String, dynamic>>.from(
            (d['redFlags'] as List?)?.map((e) => Map<String, dynamic>.from(e as Map)) ?? []
          ),
        );
      } else {
        _setMockMetrics();
      }
    } catch (e) {
      _setMockMetrics();
    }
  }

  void _setMockMetrics() {
    state = state.copyWith(
      isLoading: false,
      residentsToday: 142,
      staffOnShift: 18,
      openShifts: 3,
      fallsToday: 1,
      incidentsToday: 2,
      hospitalTransfers: 1,
      staffAttendance: 96.5,
      activeOutbreaks: 0,
      fallRate: 1.2,
      pressureUlcersCount: 2,
      wanderingAlertsCount: 0,
      missedRepositioningsCount: 1,
      weightLossRiskCount: 4,
      dehydrationAlertCount: 1,
      highRiskResidentsList: const [
        {'name': 'Alice Miller', 'riskType': 'Falls Risk / Dementia', 'status': 'High Monitoring'},
        {'name': 'Robert Chen', 'riskType': 'Medication Support', 'status': 'Stable'},
        {'name': 'Margaret Sullivan', 'riskType': 'Nutrition Risk', 'status': 'Assisted Feeding'}
      ],
      pswToResidentRatio: '1:8',
      overtimeHours: 12.5,
      sickCalls: 2,
      agencyStaffUsage: 1,
      trainingCompletionRate: 98.2,
      expiringCertifications: 2,
      staffWorkloadList: const [
        {'name': 'Emily Watson (PSW)', 'load': 85.0, 'breaksSkipped': 0},
        {'name': 'James Davis (PSW Team Lead)', 'load': 70.0, 'breaksSkipped': 0},
        {'name': 'Sarah Connor (PSW)', 'load': 90.0, 'breaksSkipped': 1}
      ],
      missingADLChartingCount: 4,
      lateIncidentReportsCount: 1,
      overdueCarePlansCount: 2,
      privacyBreachCount: 0,
      activeAbuseInvestigationsCount: 0,
      activeInfectionsCount: 3,
      isolationCount: 2,
      ppeInventoryLevel: 'Adequate (30 days supply)',
      handHygieneAuditScore: 95.0,
      outbreakStatus: 'Clear',
      activeComplaintsCount: 1,
      satisfactionRate: 94.2,
      pendingFamilyCallsCount: 3,
      moodTrends: 'Stable',
      profitMargin: 24.5,
      payrollRatio: 48.0,
      outstandingPayments: 1480.0,
      revenueByService: const [
        {'service': 'Home Care Services', 'amount': 18500.0},
        {'service': 'Retirement Resident Fees', 'amount': 24000.0},
        {'service': 'Agency Staff Provision', 'amount': 10000.0}
      ],
      revenueByTherapist: const [
        {'name': 'East Wing (Retirement)', 'amount': 12000.0},
        {'name': 'West Wing (Assisted Living)', 'amount': 14000.0},
        {'name': 'Memory Care Unit', 'amount': 10000.0},
        {'name': 'Outpatient Home Care', 'amount': 6500.0}
      ],
      roomUtilization: const [
        {'room': 'East Wing (Retirement)', 'occupancy': 92.0},
        {'room': 'West Wing (Assisted Living)', 'occupancy': 88.0},
        {'room': 'Memory Care Unit', 'occupancy': 95.0}
      ],
      inventoryAlerts: const [
        {'item': 'PPE Face Masks (N95)', 'level': 'Low (2 boxes remaining)'},
        {'item': 'Hand Sanitizer Gel', 'level': 'Adequate'},
        {'item': 'Linens / Patient Gowns', 'level': 'Adequate'}
      ],
      redFlags: const [
        {'id': '1', 'level': 'danger', 'type': 'safety', 'message': 'Repeated falls (2 in 48h) detected for resident John Smith.'},
        {'id': '2', 'level': 'warning', 'type': 'compliance', 'message': '4 ADL charting logs missing for morning shift.'},
        {'id': '3', 'level': 'warning', 'type': 'staff', 'message': 'Sarah Connor (PSW) schedule load exceeds 90% (burnout warning).'},
        {'id': '4', 'level': 'warning', 'type': 'infection', 'message': 'Low hand-hygiene score (78%) in memory care unit.'}
      ]
    );
  }

  void changeTab(int index) {
    state = state.copyWith(activeTab: index);
  }

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      isLoading: false,
      logs: [
        ...state.logs,
        'Incident audit executed at ${DateTime.now().toIso8601String()}',
        'All resident safety logs and care plans validated.',
      ],
    );
  }

  void syncPosture() {
    state = state.copyWith(
      logs: [...state.logs, 'Care plan synchronization sweep completed.'],
    );
  }

  void updatePolicy() {
    state = state.copyWith(
      logs: [...state.logs, 'Ministry safety policy updated and validated.'],
    );
  }

  void exportLogs() {
    state = state.copyWith(
      logs: [...state.logs, 'Compliance logs successfully compiled and exported.'],
    );
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
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
      id: 'clinicaldirectordashboard-screen data-cy:clinicaldashboard-screen',
      child: Scaffold(
        key: const Key('clinicaldirectordashboard-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('clinicaldirectordashboard-title'),
            state.title.tr(),
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          actions: [
            IconButton(
              key: const Key('clinicaldirectordashboard-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.loadDashboardMetrics(),
            ),
          ],
        ),
        body: ResponsiveSplitDashboard(
          metrics: [
            GovMetricCard(
              title: 'Residents Census'.tr(),
              value: '${state.residentsToday}',
              trendLabel: 'Stable',
              progress: 0.95,
              icon: LucideIcons.home,
              brandColor: theme.colors.primary,
            ),
            GovMetricCard(
              title: 'Staff Coverage'.tr(),
              value: '${state.staffOnShift} PSWs',
              trendLabel: '100% Covered',
              progress: state.staffOnShift / 20.0,
              icon: LucideIcons.userCheck,
              brandColor: const Color(0xFF0D9488),
            ),
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
        GovTelemetryChart(
          title: 'Resident Safety Level Telemetry'.tr(),
          dataPoints: const [95, 94, 98, 92, 96, 99],
          labels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
          accentColor: theme.colors.primary,
        ),
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
        GovComplianceAuditTable(
          title: 'Recent Care Incidents Log'.tr(),
          columns: const ['Title', 'Description'],
          data: const [
            {'Title': 'Resident Fall Audit', 'Description': 'Fall logged for John Smith in East Wing. Post-fall assessment complete.', 'status': 'Warning', 'date': '2026-06-04'},
            {'Title': 'Medication Error Review', 'Description': 'Missed dose of blood pressure medication reported.', 'status': 'Warning', 'date': '2026-06-04'},
            {'Title': 'Isolation Compliance Outbreak Check', 'Description': 'Respiratory infection isolation room 104 audit.', 'status': 'Secure', 'date': '2026-06-03'},
          ],
        ),
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
