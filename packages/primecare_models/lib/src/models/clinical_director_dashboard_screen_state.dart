import 'base_logged_screen_state.dart';

class ClinicalDirectorDashboardState extends BaseLoggedScreenState {
  final bool hasValidatedMetrics;
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
  final List<Map<String, dynamic>>
  revenueByTherapist; // Representing Department Cost/Revenues

  // Operations Metrics (Facility Units & Supplies)
  final List<Map<String, dynamic>> roomUtilization; // Facility Unit Occupancy
  final List<Map<String, dynamic>> inventoryAlerts; // Essential Supply Stocks

  // Risk Alerts HUD
  final List<Map<String, dynamic>> redFlags;

  const ClinicalDirectorDashboardState({
    required super.isLoading,
    this.hasValidatedMetrics = false,
    super.error,
    required super.title,
    required super.logs,
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
    bool? hasValidatedMetrics,
    bool clearError = false,
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
      hasValidatedMetrics: hasValidatedMetrics ?? this.hasValidatedMetrics,
      error: clearError ? null : error ?? this.error,
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
      missedRepositioningsCount:
          missedRepositioningsCount ?? this.missedRepositioningsCount,
      weightLossRiskCount: weightLossRiskCount ?? this.weightLossRiskCount,
      dehydrationAlertCount:
          dehydrationAlertCount ?? this.dehydrationAlertCount,
      highRiskResidentsList:
          highRiskResidentsList ?? this.highRiskResidentsList,
      pswToResidentRatio: pswToResidentRatio ?? this.pswToResidentRatio,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      sickCalls: sickCalls ?? this.sickCalls,
      agencyStaffUsage: agencyStaffUsage ?? this.agencyStaffUsage,
      trainingCompletionRate:
          trainingCompletionRate ?? this.trainingCompletionRate,
      expiringCertifications:
          expiringCertifications ?? this.expiringCertifications,
      staffWorkloadList: staffWorkloadList ?? this.staffWorkloadList,
      missingADLChartingCount:
          missingADLChartingCount ?? this.missingADLChartingCount,
      lateIncidentReportsCount:
          lateIncidentReportsCount ?? this.lateIncidentReportsCount,
      overdueCarePlansCount:
          overdueCarePlansCount ?? this.overdueCarePlansCount,
      privacyBreachCount: privacyBreachCount ?? this.privacyBreachCount,
      activeAbuseInvestigationsCount:
          activeAbuseInvestigationsCount ?? this.activeAbuseInvestigationsCount,
      activeInfectionsCount:
          activeInfectionsCount ?? this.activeInfectionsCount,
      isolationCount: isolationCount ?? this.isolationCount,
      ppeInventoryLevel: ppeInventoryLevel ?? this.ppeInventoryLevel,
      handHygieneAuditScore:
          handHygieneAuditScore ?? this.handHygieneAuditScore,
      outbreakStatus: outbreakStatus ?? this.outbreakStatus,
      activeComplaintsCount:
          activeComplaintsCount ?? this.activeComplaintsCount,
      satisfactionRate: satisfactionRate ?? this.satisfactionRate,
      pendingFamilyCallsCount:
          pendingFamilyCallsCount ?? this.pendingFamilyCallsCount,
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
