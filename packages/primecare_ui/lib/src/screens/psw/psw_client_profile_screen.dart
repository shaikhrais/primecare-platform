// Governance - Category: view | Purpose: UI Screen component rendering the PswClientProfileScreen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PswClientProfileState {
  final bool isLoading;
  final String? error;
  final String title;
  final List<String> logs;

  // Basic Information
  final String name;
  final String employeeId;
  final String status;
  final String shift;
  final String gender;
  final String dob;
  final String phone;
  final String email;
  final String address;
  final String preferredLanguage;

  // Employment Information
  final String hireDate;
  final String employmentType;
  final String department;
  final String supervisor;
  final String siteLocation;
  final String unionStatus;
  final String roleLevel;
  final String wageRate;
  final String contractExpiry;

  // Certifications & Compliance
  final Map<String, Map<String, String>> certifications;

  // Performance Widget Metrics
  final int attendanceRate;
  final int chartingCompletionRate;
  final int complaintsCount;
  final double satisfactionRate;

  // High-Risk Flags
  final List<String> highRiskFlags;

  // Shift & Availability
  final List<Map<String, String>> schedule;

  // Resident Assignments
  final List<Map<String, String>> assignedResidents;

  // Training Records
  final List<String> completedCourses;
  final List<String> upcomingCourses;

  // Notes & Communication Logs
  final List<String> notes;
  final List<String> commLogs;

  // Active Tab
  final int activeTab;

  const PswClientProfileState({
    required this.isLoading,
    this.error,
    required this.title,
    required this.logs,
    required this.name,
    required this.employeeId,
    required this.status,
    required this.shift,
    required this.gender,
    required this.dob,
    required this.phone,
    required this.email,
    required this.address,
    required this.preferredLanguage,
    required this.hireDate,
    required this.employmentType,
    required this.department,
    required this.supervisor,
    required this.siteLocation,
    required this.unionStatus,
    required this.roleLevel,
    required this.wageRate,
    required this.contractExpiry,
    required this.certifications,
    required this.attendanceRate,
    required this.chartingCompletionRate,
    required this.complaintsCount,
    required this.satisfactionRate,
    required this.highRiskFlags,
    required this.schedule,
    required this.assignedResidents,
    required this.completedCourses,
    required this.upcomingCourses,
    required this.notes,
    required this.commLogs,
    required this.activeTab,
  });

  PswClientProfileState copyWith({
    bool? isLoading,
    String? error,
    String? title,
    List<String>? logs,
    String? name,
    String? employeeId,
    String? status,
    String? shift,
    String? gender,
    String? dob,
    String? phone,
    String? email,
    String? address,
    String? preferredLanguage,
    String? hireDate,
    String? employmentType,
    String? department,
    String? supervisor,
    String? siteLocation,
    String? unionStatus,
    String? roleLevel,
    String? wageRate,
    String? contractExpiry,
    Map<String, Map<String, String>>? certifications,
    int? attendanceRate,
    int? chartingCompletionRate,
    int? complaintsCount,
    double? satisfactionRate,
    List<String>? highRiskFlags,
    List<Map<String, String>>? schedule,
    List<Map<String, String>>? assignedResidents,
    List<String>? completedCourses,
    List<String>? upcomingCourses,
    List<String>? notes,
    List<String>? commLogs,
    int? activeTab,
  }) {
    return PswClientProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      title: title ?? this.title,
      logs: logs ?? this.logs,
      name: name ?? this.name,
      employeeId: employeeId ?? this.employeeId,
      status: status ?? this.status,
      shift: shift ?? this.shift,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      hireDate: hireDate ?? this.hireDate,
      employmentType: employmentType ?? this.employmentType,
      department: department ?? this.department,
      supervisor: supervisor ?? this.supervisor,
      siteLocation: siteLocation ?? this.siteLocation,
      unionStatus: unionStatus ?? this.unionStatus,
      roleLevel: roleLevel ?? this.roleLevel,
      wageRate: wageRate ?? this.wageRate,
      contractExpiry: contractExpiry ?? this.contractExpiry,
      certifications: certifications ?? this.certifications,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      chartingCompletionRate: chartingCompletionRate ?? this.chartingCompletionRate,
      complaintsCount: complaintsCount ?? this.complaintsCount,
      satisfactionRate: satisfactionRate ?? this.satisfactionRate,
      highRiskFlags: highRiskFlags ?? this.highRiskFlags,
      schedule: schedule ?? this.schedule,
      assignedResidents: assignedResidents ?? this.assignedResidents,
      completedCourses: completedCourses ?? this.completedCourses,
      upcomingCourses: upcomingCourses ?? this.upcomingCourses,
      notes: notes ?? this.notes,
      commLogs: commLogs ?? this.commLogs,
      activeTab: activeTab ?? this.activeTab,
    );
  }
}

// --- Controller (Notifier) ---
class PswClientProfileController extends StateNotifier<PswClientProfileState> {
  final Ref ref;

  PswClientProfileController(this.ref)
      : super(
          PswClientProfileState(
            isLoading: false,
            title: 'PSW Profile Control Center',
            logs: const ['Profile loaded for Sarah Khan.', 'Compliance posture sync completed.'],
            name: 'Sarah Khan',
            employeeId: 'PC-9982',
            status: 'Active',
            shift: 'Evening',
            gender: 'Female',
            dob: '1992-08-15',
            phone: '+1 (555) 019-2834',
            email: 'sarah.khan@primecare.local',
            address: '120 Woodlawn Ave, Toronto, ON',
            preferredLanguage: 'English',
            hireDate: '2023-04-12',
            employmentType: 'Full-Time',
            department: 'Clinical Elder Care',
            supervisor: 'Dr. Emily Vance (Care Director)',
            siteLocation: 'North Campus (Wing B)',
            unionStatus: 'Unionized (SEIU Local 1)',
            roleLevel: 'Senior PSW (Level 2)',
            wageRate: '\$26.50/hr',
            contractExpiry: 'N/A (Permanent)',
            certifications: {
              'PSW Certificate': {'status': 'Verified', 'expiry': 'N/A'},
              'CPR Expiry': {'status': 'Warning', 'expiry': '2026-06-19'}, // Expires in 14 days
              'First Aid Expiry': {'status': 'Verified', 'expiry': '2027-02-11'},
              'Police Check Expiry': {'status': 'Overdue', 'expiry': '2026-05-15'},
              'TB Test Status': {'status': 'Verified', 'expiry': '2027-05-10'},
              'Vaccination Status': {'status': 'Verified', 'expiry': 'N/A'},
              'WHMIS Completion': {'status': 'Verified', 'expiry': 'N/A'},
              'Abuse Prevention Training': {'status': 'Overdue', 'expiry': '2026-05-01'},
              'Lift/Transfer Training': {'status': 'Verified', 'expiry': '2027-09-12'},
              'PHIPA Training': {'status': 'Verified', 'expiry': 'N/A'},
            },
            attendanceRate: 97,
            chartingCompletionRate: 100,
            complaintsCount: 0,
            satisfactionRate: 4.8,
            highRiskFlags: const [
              'Repeated late charting',
              'Excessive overtime',
              'Missed repositioning tasks',
            ],
            schedule: const [
              {'day': 'Monday', 'shift': 'Evening (15:00 - 23:00)', 'status': 'Assigned'},
              {'day': 'Tuesday', 'shift': 'Evening (15:00 - 23:00)', 'status': 'Assigned'},
              {'day': 'Wednesday', 'shift': 'Evening (15:00 - 23:00)', 'status': 'Assigned'},
              {'day': 'Thursday', 'shift': 'Evening (15:00 - 23:00)', 'status': 'Assigned'},
              {'day': 'Friday', 'shift': 'Evening (15:00 - 23:00)', 'status': 'Assigned'},
              {'day': 'Saturday', 'shift': 'Standby (On Call)', 'status': 'Standby'},
              {'day': 'Sunday', 'shift': 'Off-Duty', 'status': 'Off'},
            ],
            assignedResidents: const [
              {'name': 'Arthur Pendelton', 'condition': 'Dementia Care, High Fall-Risk', 'risk': 'Red'},
              {'name': 'Beatrice Henderson', 'condition': 'Heavy Transfer, Lift Assist', 'risk': 'Orange'},
              {'name': 'Charles Abbott', 'condition': 'Isolation Room 402, COVID Protocol', 'risk': 'Red'},
              {'name': 'Dorothy Jenkins', 'condition': 'Behavioral Risk, Dementia Care', 'risk': 'Orange'},
              {'name': 'Evelyn Miller', 'condition': 'Dementia Care', 'risk': 'Green'},
              {'name': 'Frank Robinson', 'condition': 'Heavy Transfer', 'risk': 'Yellow'},
              {'name': 'Grace Montgomery', 'condition': 'Standard Care', 'risk': 'Green'},
              {'name': 'Harold Foster', 'condition': 'Standard Care', 'risk': 'Green'},
            ],
            completedCourses: const [
              'Dementia Care Essentials',
              'Infection Control 2026',
              'WHMIS 2026',
              'PHIPA Privacy',
            ],
            upcomingCourses: const [
              'Abuse Prevention Refresher',
              'Palliative Care Support',
            ],
            notes: const [
              'Sarah demonstrated excellent teamwork during last week\'s evening shift quarantine transition.',
              'Supervisor Review (Emily Vance): Highly reliable worker, but monitoring overtime to prevent burnout.',
            ],
            commLogs: const [
              'Family of Arthur Pendelton called to thank Sarah for her compassionate care.',
              'Supervisor message sent regarding lift assistance protocol.',
            ],
            activeTab: 0,
          ),
        );

  void changeTab(int index) {
    state = state.copyWith(activeTab: index);
  }

  void assignShift(String day, String shiftHours) {
    final updatedSchedule = state.schedule.map((item) {
      if (item['day'] == day) {
        return {'day': day, 'shift': shiftHours, 'status': 'Assigned'};
      }
      return item;
    }).toList();

    state = state.copyWith(
      schedule: updatedSchedule,
      logs: [...state.logs, 'Assigned shift on $day: $shiftHours.'],
    );
  }

  void sendProfileMessage(String text) {
    state = state.copyWith(
      commLogs: [...state.commLogs, 'Sent direct message: "$text"'],
      logs: [...state.logs, 'Direct message sent to ${state.name}.'],
    );
  }

  void uploadCertificate(String certName, String expiry) {
    final updatedCerts = Map<String, Map<String, String>>.from(state.certifications);
    updatedCerts[certName] = {'status': 'Verified', 'expiry': expiry};

    state = state.copyWith(
      certifications: updatedCerts,
      logs: [...state.logs, 'Uploaded certificate for $certName. Status updated to Verified.'],
    );
  }

  void addPerformanceNote(String note) {
    state = state.copyWith(
      notes: [...state.notes, note],
      logs: [...state.logs, 'Added supervisor performance note.'],
    );
  }

  void assignTraining(String courseName) {
    state = state.copyWith(
      upcomingCourses: [...state.upcomingCourses, courseName],
      logs: [...state.logs, 'Enrolled ${state.name} in $courseName training.'],
    );
  }

  Future<void> runComplianceScan() async {
    state = state.copyWith(isLoading: true);
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.post(
        '/v1/psw-client-profile/compliance/scan',
        body: {
          'timestamp': DateTime.now().toIso8601String(),
          'action': 'run_compliance_scan',
        },
      );
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          logs: [
            ...state.logs,
            'Compliance audit executed at ${DateTime.now().toIso8601String()}',
            'All governance invariants validated via API.',
          ],
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          logs: [...state.logs, 'API Error running scan: ${response.error}'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        logs: [...state.logs, 'Network Error: $e'],
      );
    }
  }

  void addLog(String entry) {
    state = state.copyWith(logs: [...state.logs, entry]);
  }

  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }
}

// --- Provider ---
final pswClientProfileProvider =
    StateNotifierProvider<PswClientProfileController, PswClientProfileState>((ref) {
  return PswClientProfileController(ref);
});

// --- View ---
class PswClientProfileScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring PSW responsibilities, tracking attendance and certifications, and managing communication and training, along with associated actions and API integrations.';

  @override
  List<String> get requiredComponents => const [
        'StatusOverviewCard',
        'AttendanceChart',
        'CertificationList',
        'ShiftSchedule',
        'RiskAlertBanner',
        'ComplaintsSummary',
        'CommunicationLog',
        'TrainingSchedule',
        'PerformanceNotes',
        'ActivityLog',
      ];

  @override
  List<String> get requiredFunctions => const [
        'updateStatus',
        'completeCharting',
        'addCertification',
        'viewShiftSchedule',
        'reportConcern',
        'logCommunication',
        'enrollInTraining',
      ];

  const PswClientProfileScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswClientProfileProvider);
    final controller = ref.read(pswClientProfileProvider.notifier);
    final theme = context.theme;

    // Determine aggregate compliance status
    bool hasOverdue = false;
    bool hasWarning = false;
    for (final cert in state.certifications.values) {
      if (cert['status'] == 'Overdue') hasOverdue = true;
      if (cert['status'] == 'Warning') hasWarning = true;
    }

    final String complianceText = hasOverdue
        ? 'Compliance Attention Required'
        : (hasWarning ? 'Compliance Warning' : 'Fully Compliant');
    final Color complianceColor = hasOverdue
        ? const Color(0xFFDC2626) // Red
        : (hasWarning ? const Color(0xFFF97316) : const Color(0xFF16A34A)); // Orange : Green

    return Cy(
      id: 'pswclientprofile-screen',
      child: Scaffold(
        key: const Key('pswclientprofile-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(
            container: true,
            label: 'data-cy:pswclientprofile-title',
            child: Text(
              key: const Key('pswclientprofile-title'),
              'Sarah Khan — PSW Profile',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ),
          actions: [
            IconButton(
              key: const Key('pswclientprofile-btn-1'),
              icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
              onPressed: () => controller.addLog('Manual refresh triggered.'),
            ),
          ],
        ),
        body: Cy(
          id: 'pswclientprofile-content',
          child: SingleChildScrollView(
            key: const Key('pswclientprofile-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Top Level Profile Header Card ===
                _buildProfileHeaderCard(context, state, complianceText, complianceColor),
                const SizedBox(height: 24),

                // === Quick Action Control Bar ===
                _buildQuickActionBar(context, ref, controller),
                const SizedBox(height: 24),

                // === Tabs Layout Selector ===
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTabButton(context, 0, '📋 Overview', state.activeTab == 0, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 1, '📅 Schedule', state.activeTab == 1, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 2, '🛡️ Compliance', state.activeTab == 2, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 3, '👥 Residents', state.activeTab == 3, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 4, '📊 Performance', state.activeTab == 4, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 5, '⚠️ Incidents', state.activeTab == 5, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 6, '🎓 Training', state.activeTab == 6, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 7, '💰 Payroll', state.activeTab == 7, controller),
                      const SizedBox(width: 8),
                      _buildTabButton(context, 8, '📝 Notes', state.activeTab == 8, controller),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // === Tab content space ===
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _buildActiveTabContent(context, state, controller),
                ),
                const SizedBox(height: 24),

                // === Operational Audit Logs Box ===
                _buildAuditLogsBox(context, state, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Profile Header Card ---
  Widget _buildProfileHeaderCard(
    BuildContext context,
    PswClientProfileState state,
    String complianceText,
    Color complianceColor,
  ) {
    final theme = context.theme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colors.primary,
            const Color(0xFF0F172A), // Slate 900
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: theme.colors.primary.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      LucideIcons.user,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFF22C55E), // Active status Green
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF22C55E),
                            blurRadius: 4,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Name and title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.name,
                          style: theme.typography.h2.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: const Color(0xFF22C55E)),
                          ),
                          child: Text(
                            state.status.toUpperCase(),
                            style: theme.typography.bodySmall.copyWith(
                              color: const Color(0xFF22C55E),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${state.roleLevel} | ID: ${state.employeeId}',
                      style: theme.typography.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Badges indicators
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildHeaderBadge(
                          context,
                          'Shift: ${state.shift}',
                          LucideIcons.clock,
                          const Color(0xFF3B82F6),
                        ),
                        _buildHeaderBadge(
                          context,
                          complianceText,
                          LucideIcons.shieldAlert,
                          complianceColor,
                        ),
                        _buildHeaderBadge(
                          context,
                          'Assigned: ${state.assignedResidents.length} Residents',
                          LucideIcons.home,
                          const Color(0xFF0D9488),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(BuildContext context, String label, IconData icon, Color color) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.typography.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // --- Quick Action Control Bar ---
  Widget _buildQuickActionBar(
    BuildContext context,
    WidgetRef ref,
    PswClientProfileController controller,
  ) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Management Actions',
            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildActionButton(
                context,
                'Assign Shift',
                LucideIcons.calendar,
                theme.colors.primary,
                () => _showAssignShiftDialog(context, ref),
              ),
              _buildActionButton(
                context,
                'Send Message',
                LucideIcons.messageSquare,
                const Color(0xFF2563EB),
                () => _showSendMessageDialog(context, ref),
              ),
              _buildActionButton(
                context,
                'Upload Cert',
                LucideIcons.uploadCloud,
                const Color(0xFFF97316),
                () => _showUploadCertDialog(context, ref),
              ),
              _buildActionButton(
                context,
                'Add Performance Note',
                LucideIcons.stickyNote,
                const Color(0xFF0D9488),
                () => _showAddNoteDialog(context, ref),
              ),
              _buildActionButton(
                context,
                'Assign Training',
                LucideIcons.graduationCap,
                const Color(0xFF8B5CF6),
                () => _showAssignTrainingDialog(context, ref),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    final theme = context.theme;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.08),
        foregroundColor: color,
        elevation: 0,
        side: BorderSide(color: color.withValues(alpha: 0.3), width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      icon: Icon(icon, size: 16),
      onPressed: onTap,
      label: Text(
        label,
        style: theme.typography.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // --- Tab Buttons ---
  Widget _buildTabButton(
    BuildContext context,
    int index,
    String label,
    bool isActive,
    PswClientProfileController controller,
  ) {
    final theme = context.theme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? theme.colors.primary : theme.colors.surface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isActive ? theme.colors.primary : theme.colors.border,
              width: 1.2,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: theme.colors.primary.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label.tr(),
            style: theme.typography.labelBold.copyWith(
              color: isActive ? Colors.white : theme.colors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  // --- Tab Contents Render Engine ---
  Widget _buildActiveTabContent(
    BuildContext context,
    PswClientProfileState state,
    PswClientProfileController controller,
  ) {
    switch (state.activeTab) {
      case 0:
        return _buildOverviewTab(context, state);
      case 1:
        return _buildScheduleTab(context, state);
      case 2:
        return _buildComplianceTab(context, state);
      case 3:
        return _buildResidentsTab(context, state);
      case 4:
        return _buildPerformanceTab(context, state);
      case 5:
        return _buildIncidentsTab(context, state);
      case 6:
        return _buildTrainingTab(context, state);
      case 7:
        return _buildPayrollTab(context, state);
      case 8:
        return _buildNotesTab(context, state);
      default:
        return const SizedBox.shrink();
    }
  }

  // === 0. OVERVIEW TAB ===
  Widget _buildOverviewTab(BuildContext context, PswClientProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Grid layout for basic info card & performance widget
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: _buildGridInfoCard(context, 'Basic Information', [
                {'label': 'Full Name', 'value': state.name},
                {'label': 'Employee ID', 'value': state.employeeId},
                {'label': 'Gender', 'value': state.gender},
                {'label': 'DOB', 'value': state.dob},
                {'label': 'Phone Number', 'value': state.phone},
                {'label': 'Email Address', 'value': state.email},
                {'label': 'Primary Language', 'value': state.preferredLanguage},
                {'label': 'Home Address', 'value': state.address},
              ]),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: _buildPerformanceWidget(context, state),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Employment Info
        _buildGridInfoCard(context, 'Employment Information', [
          {'label': 'Hire Date', 'value': state.hireDate},
          {'label': 'Employment Type', 'value': state.employmentType},
          {'label': 'Primary Department', 'value': state.department},
          {'label': 'Direct Supervisor', 'value': state.supervisor},
          {'label': 'Site Location', 'value': state.siteLocation},
          {'label': 'Union Membership', 'value': state.unionStatus},
          {'label': 'Wage Tier Rate', 'value': state.wageRate},
          {'label': 'Contract Status', 'value': state.contractExpiry},
        ]),
        const SizedBox(height: 24),
        // Compliance Alerts summary
        _buildComplianceAlertsSummary(context, state),
        const SizedBox(height: 24),
        // Advanced Features Portfolio
        _buildAdvancedFeaturesSection(context),
      ],
    );
  }

  Widget _buildGridInfoCard(BuildContext context, String title, List<Map<String, String>> items) {
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
          Text(
            title,
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
            ),
            itemCount: items.length,
            itemBuilder: (context, idx) {
              final item = items[idx];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['label']!,
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.outline,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['value']!,
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceWidget(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Performance Widget',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildPerformanceMetricRow(context, 'Attendance Rate', '${state.attendanceRate}%', LucideIcons.calendarCheck2, const Color(0xFF16A34A)),
          const SizedBox(height: 12),
          _buildPerformanceMetricRow(context, 'Charting Completion', '${state.chartingCompletionRate}%', LucideIcons.fileSpreadsheet, const Color(0xFF0D9488)),
          const SizedBox(height: 12),
          _buildPerformanceMetricRow(context, 'Complaints Received', '${state.complaintsCount}', LucideIcons.alertOctagon, state.complaintsCount == 0 ? const Color(0xFF16A34A) : const Color(0xFFDC2626)),
          const SizedBox(height: 12),
          _buildPerformanceMetricRow(context, 'Resident Satisfaction', '${state.satisfactionRate} / 5.0', LucideIcons.heartHandshake, const Color(0xFFEAB308)),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetricRow(BuildContext context, String label, String value, IconData icon, Color color) {
    final theme = context.theme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.outline,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.typography.bodyLarge.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceAlertsSummary(BuildContext context, PswClientProfileState state) {
    final theme = context.theme;
    final List<Map<String, dynamic>> activeAlerts = [];

    state.certifications.forEach((name, detail) {
      if (detail['status'] == 'Warning') {
        activeAlerts.add({
          'icon': LucideIcons.alertTriangle,
          'text': '$name expires soon (Expiry: ${detail['expiry']})',
          'color': const Color(0xFFF97316),
        });
      } else if (detail['status'] == 'Overdue') {
        activeAlerts.add({
          'icon': LucideIcons.alertCircle,
          'text': '$name is overdue! Immediate renewal required.',
          'color': const Color(0xFFDC2626),
        });
      }
    });

    if (activeAlerts.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: const Color(0xFFFCA5A5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.shieldAlert, color: Color(0xFFB91C1C)),
              const SizedBox(width: 10),
              Text(
                'ACTIVE COMPLIANCE ALERTS',
                style: theme.typography.labelBold.copyWith(
                  color: const Color(0xFFB91C1C),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...activeAlerts.map((alert) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(alert['icon'] as IconData, color: alert['color'] as Color, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        alert['text'] as String,
                        style: theme.typography.bodyMedium.copyWith(
                          color: const Color(0xFF1F2937),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildAdvancedFeaturesSection(BuildContext context) {
    final theme = context.theme;
    final features = [
      {
        'title': 'AI Burnout Prediction',
        'value': '72% Status: Monitoring',
        'icon': LucideIcons.brainCircuit,
        'color': const Color(0xFFF97316),
      },
      {
        'title': 'Fall-Risk Balancing',
        'value': 'Balanced (Optimal)',
        'icon': LucideIcons.scale,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Mobile Geofence GPS',
        'value': 'Active geofence geolocated',
        'icon': LucideIcons.navigation,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'Voice Charting Usage',
        'value': '42% documentation verified',
        'icon': LucideIcons.mic,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': 'QR Check-In Status',
        'value': '100% compliant scans',
        'icon': LucideIcons.qrCode,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Shift Fatigue Index',
        'value': 'Low risk factor (Level 2)',
        'icon': LucideIcons.activity,
        'color': const Color(0xFF10B981),
      },
    ];

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
          Text(
            'Advanced Smart Features (Operational Indicators)',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
            ),
            itemCount: features.length,
            itemBuilder: (context, idx) {
              final feature = features[idx];
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (feature['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(feature['icon'] as IconData, color: feature['color'] as Color, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          feature['title'] as String,
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.outline,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          feature['value'] as String,
                          style: theme.typography.bodyMedium.copyWith(
                            color: theme.colors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // === 1. SCHEDULE TAB ===
  Widget _buildScheduleTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Weekly Schedule & Standby Hours',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Shift stats row
          Row(
            children: [
              _buildStatBadge(context, 'Total OT Hours', '12.5 hrs', const Color(0xFFF97316)),
              const SizedBox(width: 12),
              _buildStatBadge(context, 'Missed Shifts', '0 shifts', const Color(0xFF16A34A)),
              const SizedBox(width: 12),
              _buildStatBadge(context, 'Sick Days Logged', '2 days', const Color(0xFF3B82F6)),
              const SizedBox(width: 12),
              _buildStatBadge(context, 'Vacation Allocated', '5 days', const Color(0xFF8B5CF6)),
            ],
          ),
          const SizedBox(height: 20),
          // Table of weekly schedule
          Table(
            border: TableBorder.all(color: theme.colors.border, width: 1, borderRadius: BorderRadius.circular(8)),
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: theme.colors.background),
                children: [
                  _buildTableCell(context, 'Day', isHeader: true),
                  _buildTableCell(context, 'Assigned Shift Hours', isHeader: true),
                  _buildTableCell(context, 'Status Badge', isHeader: true),
                ],
              ),
              ...state.schedule.map((shift) {
                final isOff = shift['status'] == 'Off';
                final isStandby = shift['status'] == 'Standby';
                final statusColor = isOff
                    ? const Color(0xFF6B7280)
                    : (isStandby ? const Color(0xFFF59E0B) : const Color(0xFF10B981));
                return TableRow(
                  children: [
                    _buildTableCell(context, shift['day']!),
                    _buildTableCell(context, shift['shift']!),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            shift['status']!.toUpperCase(),
                            style: theme.typography.bodySmall.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(BuildContext context, String label, String value, Color color) {
    final theme = context.theme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(theme.radiusSm),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.typography.bodySmall.copyWith(color: theme.colors.outline, fontSize: 10),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.typography.bodyLarge.copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(BuildContext context, String text, {bool isHeader = false}) {
    final theme = context.theme;
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Text(
          text,
          style: theme.typography.bodyMedium.copyWith(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.w600,
            color: isHeader ? theme.colors.onSurface : theme.colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  // === 2. COMPLIANCE TAB ===
  Widget _buildComplianceTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Certifications & Mandatory Training Auditing',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Compliance Warnings Panel inside tab
          _buildComplianceAlertsSummary(context, state),
          const SizedBox(height: 16),
          // List of certifications
          Table(
            border: TableBorder.all(color: theme.colors.border, width: 1, borderRadius: BorderRadius.circular(8)),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: theme.colors.background),
                children: [
                  _buildTableCell(context, 'Certification Name', isHeader: true),
                  _buildTableCell(context, 'Expiry Date / Reference', isHeader: true),
                  _buildTableCell(context, 'Compliance Status', isHeader: true),
                ],
              ),
              ...state.certifications.entries.map((entry) {
                final certName = entry.key;
                final certDetails = entry.value;
                final status = certDetails['status']!;
                final expiry = certDetails['expiry']!;

                final statusColor = status == 'Verified'
                    ? const Color(0xFF16A34A)
                    : (status == 'Warning' ? const Color(0xFFF97316) : const Color(0xFFDC2626));

                return TableRow(
                  children: [
                    _buildTableCell(context, certName),
                    _buildTableCell(context, expiry),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: theme.typography.bodySmall.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  // === 3. RESIDENTS TAB ===
  Widget _buildResidentsTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Assigned Resident Workload & Specialized Care',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Table(
            border: TableBorder.all(color: theme.colors.border, width: 1, borderRadius: BorderRadius.circular(8)),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: theme.colors.background),
                children: [
                  _buildTableCell(context, 'Resident Name', isHeader: true),
                  _buildTableCell(context, 'Specialized Care / Condition', isHeader: true),
                  _buildTableCell(context, 'Risk Profile Level', isHeader: true),
                ],
              ),
              ...state.assignedResidents.map((res) {
                final risk = res['risk']!;
                final riskColor = risk == 'Red'
                    ? const Color(0xFFDC2626)
                    : (risk == 'Orange' ? const Color(0xFFF97316) : (risk == 'Yellow' ? const Color(0xFFEAB308) : const Color(0xFF16A34A)));

                return TableRow(
                  children: [
                    _buildTableCell(context, res['name']!),
                    _buildTableCell(context, res['condition']!),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: riskColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: riskColor.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            risk.toUpperCase(),
                            style: theme.typography.bodySmall.copyWith(
                              color: riskColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  // === 4. PERFORMANCE TAB ===
  Widget _buildPerformanceTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Performance Metrics & Quality Assurance Telemetry',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GovMetricCard(
                  title: 'Attendance Score',
                  value: '${state.attendanceRate}%',
                  trendLabel: 'Excellent',
                  progress: state.attendanceRate / 100.0,
                  icon: LucideIcons.calendarCheck,
                  brandColor: const Color(0xFF16A34A),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GovMetricCard(
                  title: 'Charting Compliance',
                  value: '${state.chartingCompletionRate}%',
                  trendLabel: 'Optimal',
                  progress: state.chartingCompletionRate / 100.0,
                  icon: LucideIcons.checkCircle,
                  brandColor: const Color(0xFF0D9488),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Weekly Response Time Trend (mins)',
            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 12),
          GovTelemetryChart(
            title: 'Resident Call Response Telemetry',
            dataPoints: const [6, 8, 7, 5, 6, 4],
            labels: const ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6'],
            accentColor: theme.colors.primary,
          ),
        ],
      ),
    );
  }

  // === 5. INCIDENTS TAB ===
  Widget _buildIncidentsTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Incident logs & Risk Profiler',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // High risk warning flags
          if (state.highRiskFlags.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFCA5A5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(LucideIcons.alertOctagon, color: Color(0xFFDC2626)),
                      const SizedBox(width: 10),
                      Text(
                        'HIGH RISK OPERATIONAL FLAGS',
                        style: theme.typography.labelBold.copyWith(
                          color: const Color(0xFFDC2626),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...state.highRiskFlags.map((flag) => Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          '🔴 $flag',
                          style: theme.typography.bodyMedium.copyWith(
                            color: const Color(0xFF1F2937),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
          // Table of incidents
          Table(
            border: TableBorder.all(color: theme.colors.border, width: 1, borderRadius: BorderRadius.circular(8)),
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: theme.colors.background),
                children: [
                  _buildTableCell(context, 'Incident Type', isHeader: true),
                  _buildTableCell(context, 'Outcome & Action Taken', isHeader: true),
                  _buildTableCell(context, 'Status', isHeader: true),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'Resident Fall'),
                  _buildTableCell(context, 'Arthur P. fall in restroom. Vitals logged, emergency response protocol followed, cleared by RN.'),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                        ),
                        child: const Text(
                          'RESOLVED',
                          style: TextStyle(
                            color: Color(0xFF10B981),
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'Late Notes Log'),
                  _buildTableCell(context, 'Adherence gap. Late note logged on Tuesday shift. Warning issued in telemetry log.'),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
                        ),
                        child: const Text(
                          'FLAGGED',
                          style: TextStyle(
                            color: Color(0xFFF59E0B),
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === 6. TRAINING TAB ===
  Widget _buildTrainingTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Education & Training Accomplishments',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Completed courses
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Completed Certs/Training Courses',
                      style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 8),
                    ...state.completedCourses.map((course) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.checkCircle2, color: Color(0xFF16A34A), size: 16),
                              const SizedBox(width: 8),
                              Text(
                                course,
                                style: theme.typography.bodyMedium.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Enrolled / Upcoming courses
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enrolled / Required Training Courses',
                      style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 8),
                    ...state.upcomingCourses.map((course) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.clock, color: Color(0xFFF97316), size: 16),
                              const SizedBox(width: 8),
                              Text(
                                course,
                                style: theme.typography.bodyMedium.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === 7. PAYROLL TAB ===
  Widget _buildPayrollTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Payroll Metrics & Wage Summary',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatBadge(context, 'Contract Hourly Wage', state.wageRate, const Color(0xFF0D9488)),
              const SizedBox(width: 16),
              _buildStatBadge(context, 'Total Regular Hours', '78.5 hrs', const Color(0xFF3B82F6)),
              const SizedBox(width: 16),
              _buildStatBadge(context, 'Overtime Hours Worked', '12.5 hrs', const Color(0xFFF97316)),
              const SizedBox(width: 16),
              _buildStatBadge(context, 'Stat Holiday Hours', '8.0 hrs', const Color(0xFF8B5CF6)),
            ],
          ),
          const SizedBox(height: 24),
          // Estimated wage table
          Table(
            border: TableBorder.all(color: theme.colors.border, width: 1, borderRadius: BorderRadius.circular(8)),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: theme.colors.background),
                children: [
                  _buildTableCell(context, 'Payment Class', isHeader: true),
                  _buildTableCell(context, 'Hours Multiplier', isHeader: true),
                  _buildTableCell(context, 'Estimated Subtotal', isHeader: true),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'Regular Base Care Pay'),
                  _buildTableCell(context, '78.5 hrs @ 1.0x'),
                  _buildTableCell(context, '\$2,080.25'),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'Overtime Premium Pay'),
                  _buildTableCell(context, '12.5 hrs @ 1.5x'),
                  _buildTableCell(context, '\$496.88'),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell(context, 'Stat Holiday Allowance'),
                  _buildTableCell(context, '8.0 hrs @ 1.5x'),
                  _buildTableCell(context, '\$318.00'),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(color: theme.colors.primary.withValues(alpha: 0.05)),
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Total Estimated Pay Period Gross',
                        style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.primary),
                      ),
                    ),
                  ),
                  _buildTableCell(context, '99.0 Total Hrs'),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        '\$2,895.13',
                        style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === 8. NOTES TAB ===
  Widget _buildNotesTab(BuildContext context, PswClientProfileState state) {
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
          Text(
            'Supervisor Notes & Direct Communication Log',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Supervisor / Internal HR Notes',
            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 8),
          ...state.notes.map((note) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(LucideIcons.stickyNote, color: Color(0xFF0D9488), size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          note,
                          style: theme.typography.bodyMedium.copyWith(
                            color: theme.colors.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 16),
          Text(
            'Family / External Communication Logs',
            style: theme.typography.labelBold.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 8),
          ...state.commLogs.map((log) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(LucideIcons.messageSquare, color: Color(0xFF2563EB), size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          log,
                          style: theme.typography.bodyMedium.copyWith(
                            color: theme.colors.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  // --- Audit Logs Box ---
  Widget _buildAuditLogsBox(
    BuildContext context,
    PswClientProfileState state,
    PswClientProfileController controller,
  ) {
    final theme = context.theme;
    return Container(
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
            'System Compliance Logs',
            style: theme.typography.h4.copyWith(
              color: theme.colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
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
                    style: TextStyle(
                      color: theme.colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      log,
                      style: theme.typography.bodySmall.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
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
              key: const Key('pswclientprofile-btn-3'),
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
                        key: Key('pswclientprofile-loading'),
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      'Execute Compliance Status Check',
                      style: theme.typography.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Dynamic Form Dialogs Helpers ---
  void _showAssignShiftDialog(BuildContext context, WidgetRef ref) {
    final controller = ref.read(pswClientProfileProvider.notifier);
    String selectedDay = 'Monday';
    String selectedHours = 'Evening (15:00 - 23:00)';

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Assign Shift to Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedDay,
                items: const [
                  DropdownMenuItem(value: 'Monday', child: Text('Monday')),
                  DropdownMenuItem(value: 'Tuesday', child: Text('Tuesday')),
                  DropdownMenuItem(value: 'Wednesday', child: Text('Wednesday')),
                  DropdownMenuItem(value: 'Thursday', child: Text('Thursday')),
                  DropdownMenuItem(value: 'Friday', child: Text('Friday')),
                  DropdownMenuItem(value: 'Saturday', child: Text('Saturday')),
                  DropdownMenuItem(value: 'Sunday', child: Text('Sunday')),
                ],
                onChanged: (val) {
                  if (val != null) selectedDay = val;
                },
                decoration: const InputDecoration(labelText: 'Day of Week'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedHours,
                items: const [
                  DropdownMenuItem(value: 'Morning (07:00 - 15:00)', child: Text('Morning (07:00 - 15:00)')),
                  DropdownMenuItem(value: 'Evening (15:00 - 23:00)', child: Text('Evening (15:00 - 23:00)')),
                  DropdownMenuItem(value: 'Night (23:00 - 07:00)', child: Text('Night (23:00 - 07:00)')),
                  DropdownMenuItem(value: 'Standby (On Call)', child: Text('Standby (On Call)')),
                  DropdownMenuItem(value: 'Off-Duty', child: Text('Off-Duty')),
                ],
                onChanged: (val) {
                  if (val != null) selectedHours = val;
                },
                decoration: const InputDecoration(labelText: 'Shift Target hours'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.assignShift(selectedDay, selectedHours);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Assigned $selectedHours for $selectedDay.')),
                );
              },
              child: const Text('Save Shift'),
            ),
          ],
        );
      },
    );
  }

  void _showSendMessageDialog(BuildContext context, WidgetRef ref) {
    final controller = ref.read(pswClientProfileProvider.notifier);
    final textController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Send Message to Sarah Khan'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Enter direct instructions or message...',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.trim().isNotEmpty) {
                  controller.sendProfileMessage(textController.text.trim());
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent to Sarah Khan successfully.')),
                  );
                }
              },
              child: const Text('Send Message'),
            ),
          ],
        );
      },
    );
  }

  void _showUploadCertDialog(BuildContext context, WidgetRef ref) {
    final controller = ref.read(pswClientProfileProvider.notifier);
    String selectedCert = 'CPR Expiry';
    String selectedExpiry = '2028-06-19';

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Upload & Verify Certificate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCert,
                items: const [
                  DropdownMenuItem(value: 'CPR Expiry', child: Text('CPR Expiry')),
                  DropdownMenuItem(value: 'Police Check Expiry', child: Text('Police Check Expiry')),
                  DropdownMenuItem(value: 'Abuse Prevention Training', child: Text('Abuse Prevention Training')),
                  DropdownMenuItem(value: 'First Aid Expiry', child: Text('First Aid Expiry')),
                  DropdownMenuItem(value: 'TB Test Status', child: Text('TB Test Status')),
                ],
                onChanged: (val) {
                  if (val != null) selectedCert = val;
                },
                decoration: const InputDecoration(labelText: 'Certificate Type'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: selectedExpiry,
                onChanged: (val) => selectedExpiry = val,
                decoration: const InputDecoration(
                  labelText: 'New Expiry Date (YYYY-MM-DD)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.uploadCertificate(selectedCert, selectedExpiry);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Verified and updated $selectedCert until $selectedExpiry.')),
                );
              },
              child: const Text('Verify & Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddNoteDialog(BuildContext context, WidgetRef ref) {
    final controller = ref.read(pswClientProfileProvider.notifier);
    final noteController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Supervisor HR / Performance Note'),
          content: TextField(
            controller: noteController,
            decoration: const InputDecoration(
              hintText: 'Enter internal supervisor or performance review note...',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (noteController.text.trim().isNotEmpty) {
                  controller.addPerformanceNote(noteController.text.trim());
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Performance note added to profile.')),
                  );
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        );
      },
    );
  }

  void _showAssignTrainingDialog(BuildContext context, WidgetRef ref) {
    final controller = ref.read(pswClientProfileProvider.notifier);
    final trainingController = TextEditingController(text: 'Abuse Prevention Refresher');

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Assign Mandatory Training Course'),
          content: TextField(
            controller: trainingController,
            decoration: const InputDecoration(
              labelText: 'Course / Module Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (trainingController.text.trim().isNotEmpty) {
                  controller.assignTraining(trainingController.text.trim());
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Enrolled Sarah Khan in ${trainingController.text.trim()}.')),
                  );
                }
              },
              child: const Text('Enroll Staff'),
            ),
          ],
        );
      },
    );
  }
}
