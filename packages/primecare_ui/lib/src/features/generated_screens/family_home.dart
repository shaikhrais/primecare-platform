import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class FamilyHomeState {
  final bool isCaregiverOnSite;
  final String caregiverName;
  final String caregiverStatus;
  final String checkInTime;
  final String elapsedMinutes;
  final List<Map<String, dynamic>> dailyLogs;
  final bool requestPending;
  final bool showSuccessNotification;

  const FamilyHomeState({
    required this.isCaregiverOnSite,
    required this.caregiverName,
    required this.caregiverStatus,
    required this.checkInTime,
    required this.elapsedMinutes,
    required this.dailyLogs,
    required this.requestPending,
    required this.showSuccessNotification,
  });

  FamilyHomeState copyWith({
    bool? isCaregiverOnSite,
    String? caregiverName,
    String? caregiverStatus,
    String? checkInTime,
    String? elapsedMinutes,
    List<Map<String, dynamic>>? dailyLogs,
    bool? requestPending,
    bool? showSuccessNotification,
  }) {
    return FamilyHomeState(
      isCaregiverOnSite: isCaregiverOnSite ?? this.isCaregiverOnSite,
      caregiverName: caregiverName ?? this.caregiverName,
      caregiverStatus: caregiverStatus ?? this.caregiverStatus,
      checkInTime: checkInTime ?? this.checkInTime,
      elapsedMinutes: elapsedMinutes ?? this.elapsedMinutes,
      dailyLogs: dailyLogs ?? this.dailyLogs,
      requestPending: requestPending ?? this.requestPending,
      showSuccessNotification: showSuccessNotification ?? this.showSuccessNotification,
    );
  }
}

// --- Controller ---
class FamilyHomeController extends StateNotifier<FamilyHomeState> {
  final Ref _ref;

  FamilyHomeController(this._ref)
      : super(
          const FamilyHomeState(
            isCaregiverOnSite: true,
            caregiverName: 'Sarah Jenkins, PSW',
            caregiverStatus: 'Assisting with Meal Preparation & Grooming',
            checkInTime: '08:30 AM',
            elapsedMinutes: '45 mins elapsed',
            dailyLogs: [
              {
                'time': '09:00 AM',
                'type': 'Medication',
                'title': 'Morning Dosage Administered',
                'desc': 'All daily morning prescription medications confirmed and checked by supervisor RN.',
                'status': 'success',
              },
              {
                'time': '08:45 AM',
                'type': 'Nutrition',
                'title': 'Breakfast Intake Logged',
                'desc': 'Consumed 95% of oatmeal meal, fresh berries, and 300ml of hydration.',
                'status': 'info',
              },
              {
                'time': 'Yesterday',
                'type': 'Activity',
                'title': 'Physical Rehabilitation Walk',
                'desc': 'Completed 15 minutes of outdoor lawn exercises using stable walker support.',
                'status': 'info',
              },
            ],
            requestPending: false,
            showSuccessNotification: false,
          ),
        );

  void bookVisit(String date, String type, int hours) {
    state = state.copyWith(requestPending: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/client_dashboard',
            eventType: 'family_home_visit_requested',
            metadata: {'date': date, 'type': type, 'hours': hours},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      final newLog = {
        'time': 'Just now',
        'type': 'Scheduling',
        'title': 'Extra Visit Requested',
        'desc': 'Requested a $hours-hour $type visit for $date. Matching caregiver resources...',
        'status': 'warning',
      };
      state = state.copyWith(
        requestPending: false,
        showSuccessNotification: true,
        dailyLogs: [newLog, ...state.dailyLogs],
      );
    });
  }

  void dismissNotification() {
    state = state.copyWith(showSuccessNotification: false);
  }

  void logNurseCall() {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/client_dashboard',
            eventType: 'family_home_call_coordinator',
            metadata: {'timestamp': DateTime.now().toIso8601String()},
          );
    } catch (_) {}
  }
}

// --- Provider ---
final familyHomeControllerProvider =
    StateNotifierProvider<FamilyHomeController, FamilyHomeState>((ref) {
  return FamilyHomeController(ref);
});

// --- View ---
class FamilyHome extends GovernedConsumerWidget {
  const FamilyHome({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(familyHomeControllerProvider);
    final controller = ref.read(familyHomeControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.home, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Family Care Portal',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.showSuccessNotification)
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.checkCircle, color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Visit request submitted successfully!',
                        style: theme.typography.bodyMedium.copyWith(color: Colors.green.shade800),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.x, size: 16, color: Colors.green),
                      onPressed: controller.dismissNotification,
                    ),
                  ],
                ),
              ),

            // Welcome Header
            Text(
              'Welcome Back, Thompson Family',
              style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
            ),
            const SizedBox(height: 6),
            Text(
              'Monitoring active care for Margaret Thompson',
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
            ),
            const SizedBox(height: 24),

            // Caregiver Live Tracker HUD
            PrimeCareCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'CAREGIVER CURRENTLY ON-SITE',
                            style: theme.typography.labelBold.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(theme.radiusSm),
                        ),
                        child: Text(
                          state.elapsedMinutes,
                          style: theme.typography.labelMedium.copyWith(color: theme.colors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                        child: Icon(LucideIcons.user, color: theme.colors.primary, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.caregiverName,
                              style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state.caregiverStatus,
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(LucideIcons.clock, color: theme.colors.onSurfaceVariant, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Shift Started: ${state.checkInTime}',
                            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(LucideIcons.mapPin, color: theme.colors.onSurfaceVariant, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'GPS Check-in Verified',
                            style: theme.typography.bodySmall.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Quick Actions Panel
            Text('Quick Operations', style: theme.typography.h3),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.logNurseCall();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Simulating Encrypted Call to Nurse Coordinator (555-0199)...'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        border: Border.all(color: theme.colors.divider),
                        boxShadow: theme.shadowsSurface1,
                      ),
                      child: Column(
                        children: [
                          Icon(LucideIcons.phoneCall, color: theme.colors.primary, size: 28),
                          const SizedBox(height: 12),
                          Text('Call Coordinator', style: theme.typography.labelBold),
                          const SizedBox(height: 4),
                          Text('Direct emergency nursing line', textAlign: TextAlign.center, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _showRequestVisitSheet(context, controller),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        border: Border.all(color: theme.colors.divider),
                        boxShadow: theme.shadowsSurface1,
                      ),
                      child: Column(
                        children: [
                          Icon(LucideIcons.calendarPlus, color: theme.colors.primary, size: 28),
                          const SizedBox(height: 12),
                          Text('Request Visit', style: theme.typography.labelBold),
                          const SizedBox(height: 4),
                          Text('Book extra care shift window', textAlign: TextAlign.center, style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Daily Updates Timeline
            Text('Daily Updates Stream', style: theme.typography.h3),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.dailyLogs.length,
              itemBuilder: (context, index) {
                final log = state.dailyLogs[index];
                Color statusColor = theme.colors.primary;
                if (log['status'] == 'success') statusColor = Colors.green;
                if (log['status'] == 'warning') statusColor = Colors.orange;

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Timeline indicator line
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 2,
                              color: index == state.dailyLogs.length - 1
                                  ? Colors.transparent
                                  : theme.colors.divider,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Timeline Card
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colors.surface,
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                            border: Border.all(color: theme.colors.divider),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(theme.radiusSm),
                                    ),
                                    child: Text(
                                      log['type'] as String,
                                      style: theme.typography.bodySmall.copyWith(color: statusColor, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    log['time'] as String,
                                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                log['title'] as String,
                                style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                log['desc'] as String,
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ],
                          ),
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
    );
  }

  void _showRequestVisitSheet(
    BuildContext context,
    FamilyHomeController controller,
  ) {
    final theme = context.theme;
    String selectedDate = '2026-05-25';
    String selectedType = 'Personal Support Worker (PSW)';
    int selectedHours = 4;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 32,
              ),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colors.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Request Extra Care Visit', style: theme.typography.h3),
                  const SizedBox(height: 6),
                  Text(
                    'Book supplementary care slots with our accredited clinical roster.',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),

                  // Caregiver Type choice
                  Text('Caregiver Discipline', style: theme.typography.labelBold),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: selectedType,
                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusDefault)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Personal Support Worker (PSW)', child: Text('Personal Support Worker (PSW)')),
                      DropdownMenuItem(value: 'Registered Practical Nurse (RPN)', child: Text('Registered Practical Nurse (RPN)')),
                      DropdownMenuItem(value: 'Registered Nurse (RN)', child: Text('Registered Nurse (RN)')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => selectedType = val);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Visit Date Choice
                  Text('Target Date', style: theme.typography.labelBold),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: selectedDate,
                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(theme.radiusDefault)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    items: const [
                      DropdownMenuItem(value: '2026-05-25', child: Text('May 25, 2026 (Monday)')),
                      DropdownMenuItem(value: '2026-05-26', child: Text('May 26, 2026 (Tuesday)')),
                      DropdownMenuItem(value: '2026-05-27', child: Text('May 27, 2026 (Wednesday)')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => selectedDate = val);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Duration Slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Duration Hours', style: theme.typography.labelBold),
                      Text('$selectedHours Hours', style: theme.typography.bodyMedium.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: selectedHours.toDouble(),
                    min: 2,
                    max: 12,
                    divisions: 10,
                    activeColor: theme.colors.primary,
                    inactiveColor: theme.colors.divider,
                    onChanged: (val) {
                      setState(() => selectedHours = val.toInt());
                    },
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(theme.radiusDefault),
                        ),
                      ),
                      onPressed: () {
                        controller.bookVisit(selectedDate, selectedType, selectedHours);
                        Navigator.pop(context);
                      },
                      child: Text('Submit Visit Proposal', style: theme.typography.labelBold),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
