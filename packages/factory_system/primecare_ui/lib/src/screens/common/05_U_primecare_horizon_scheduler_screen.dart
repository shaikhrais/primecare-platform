// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/components/scheduler/01_I_horizon_grid.dart';

class PrimeCareHorizonSchedulerScreen extends ConsumerWidget {
  const PrimeCareHorizonSchedulerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(executionGateProvider)
        .passGate(
          ExecutionGateCategory.navigationLayer,
          'Navigated to primecare horizon scheduler screen',
        );

    ref.listen(auraIntentProvider, (previous, next) {
      if (next != null && next.actions.isNotEmpty) {
        final action = next.actions.first.type;
        if (action == AuraActionType.reassign) {
          _showAuraActionDialog(context, ref, next);
        }
      }
    });

    final scheduleAsync = ref.watch(horizonScheduleProvider);

    return Scaffold(
      backgroundColor: PrimeCareColors.black,
      body: scheduleAsync.when(
        data: (schedule) => Row(
          children: [
            // Main Content Space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Area
                  _buildHeader(context, ref),

                  // Horizon Grid
                  Expanded(child: HorizonGrid(schedule: schedule)),
                ],
              ),
            ),

            // Receptionist Control Sidebar (Glassmorphism)
            _buildSidebar(context, ref, schedule),
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Text(LocaleKeys.dashboards_common_labels_error___err.tr()),
        ),
      ),
    );
  }

  void _showAuraActionDialog(
    BuildContext context,
    WidgetRef ref,
    AuraIntent intent,
  ) {
    // Checkpoint: Validation boundary to prevent malformed dynamic modals
    if (intent.description.isEmpty || intent.actions.isEmpty) return;
    if (intent.actions.first.type == AuraActionType.unknown) return;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1B262C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: PrimeCareColors.purple),
        ),
        title: Row(
          children: [
            const Icon(LucideIcons.sparkles, color: PrimeCareColors.purple),
            const SizedBox(width: 8),
            Text(
              intent.actions.isNotEmpty &&
                      intent.actions.first.type == AuraActionType.reassign
                  ? 'Reassignment Proposed'
                  : 'Scheduling Proposed',
              style: const TextStyle(
                color: PrimeCareColors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Text(
          intent.description,
          style: TextStyle(color: PrimeCareColors.white.withValues(alpha: 0.6)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: PrimeCareColors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimeCareColors.purple,
              foregroundColor: PrimeCareColors.white,
            ),
            onPressed: () {
              // Execute logic
              ref
                  .read(executionGateProvider)
                  .passGate(
                    ExecutionGateCategory.scheduler,
                    'Executing Aura Proposed Action',
                    metadata: {
                      'intentId': intent.id,
                      'description': intent.description,
                    },
                  );
              Navigator.of(ctx).pop();
            },
            child: Text(LocaleKeys.dashboards_common_labels_confirm.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    final auraActive = ref.watch(auraActiveVisualizationProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.2),
        border: const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Institutional Horizon',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Centralized Staff Matrix & Appointment Control',
                style: TextStyle(
                  color: PrimeCareColors.white.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildMetricButton(
                context,
                'Total Staff',
                '48',
                LucideIcons.users,
              ),
              const SizedBox(width: 12),
              _buildMetricButton(context, 'Waiting', '12', LucideIcons.clock),
              const SizedBox(width: 16),
              // Global Aura Toggle
              InkWell(
                onTap: () {
                  final newState = !auraActive;
                  ref
                      .read(executionGateProvider)
                      .passGate(
                        ExecutionGateCategory.ui,
                        'Toggling Aura Forecaster',
                        metadata: {'enabled': newState},
                      );
                  ref
                      .read(auraActiveVisualizationProvider.notifier)
                      .update(newState);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: auraActive
                        ? PrimeCareColors.purple
                        : PrimeCareColors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: auraActive
                          ? PrimeCareColors.purple
                          : Colors.white10,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.sparkles,
                        size: 16,
                        color: auraActive
                            ? PrimeCareColors.purple
                            : PrimeCareColors.white.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Aura Forecaster',
                        style: TextStyle(
                          color: auraActive
                              ? PrimeCareColors.purple
                              : PrimeCareColors.white.withValues(alpha: 0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricButton(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: PrimeCareColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: PrimeCareColors.skyBlue),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: PrimeCareColors.white.withValues(alpha: 0.6),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(
    BuildContext context,
    WidgetRef ref,
    HorizonSchedule schedule,
  ) {
    final auraPulse = ref.watch(auraPulseProvider).value;
    final scheduledAnomalies = ref.watch(schedulerAnomalyProvider);

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.4),
        border: Border(left: BorderSide(color: Colors.white10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareAuraCard(
              insights: [
                IntelligenceInsight(
                  id: 'res_cap_1',
                  title: LocaleKeys
                      .dashboards_common_labels_resource_optimization
                      .tr(),
                  summary: 'Laser Alpha is idle. Room 102 available soon.',
                  impact: InsightImpact.info,
                ),
                IntelligenceInsight(
                  id: 'staff_1_p',
                  title: LocaleKeys.dashboards_common_labels_high_pressure_alert
                      .tr(),
                  summary: 'Dr. Shaikh is over capacity.',
                  impact: InsightImpact.caution,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // NEW: Institutional Capacity Monitor
            Text(
              'INSTITUTIONAL CAPACITY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: PrimeCareColors.white.withValues(alpha: 0.6),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            ...schedule.resources.map((res) {
              final isAssigned = schedule.appointments.any(
                (a) =>
                    a.resourceId == res.id &&
                    a.startTime.isBefore(
                      DateTime.now().add(const Duration(minutes: 30)),
                    ) &&
                    a.endTime.isAfter(DateTime.now()),
              );

              final isPulseAnomalous =
                  auraPulse != null &&
                  auraPulse.metadata?['resourceId'] == res.id;
              final isScheduledAnomalous = scheduledAnomalies.any(
                (evt) => evt.metadata?['resourceId'] == res.id,
              );
              final isAnomalous = isPulseAnomalous || isScheduledAnomalous;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isAnomalous
                            ? PrimeCareColors.rose
                            : isAssigned
                            ? const Color(0xFF6366F1).withValues(alpha: 0.1)
                            : PrimeCareColors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        res.type == ResourceType.room
                            ? LucideIcons.home
                            : LucideIcons.zap,
                        size: 14,
                        color: isAnomalous
                            ? PrimeCareColors.rose
                            : isAssigned
                            ? const Color(0xFF6366F1)
                            : Colors.white24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            res.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isAssigned || isAnomalous
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isAnomalous
                                  ? PrimeCareColors.rose
                                  : (isAssigned
                                        ? PrimeCareColors.white
                                        : PrimeCareColors.white.withValues(
                                            alpha: 0.6,
                                          )),
                            ),
                          ),
                          Text(
                            isAnomalous
                                ? 'Anomaly Detected'
                                : (isAssigned ? 'In Use' : 'Ready'),
                            style: TextStyle(
                              fontSize: 9,
                              color: isAnomalous
                                  ? PrimeCareColors.rose
                                  : isAssigned
                                  ? const Color(
                                      0xFF6366F1,
                                    ).withValues(alpha: 0.7)
                                  : PrimeCareColors.emerald,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 40),
            Text(
              'Unassigned Queue',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildQueueItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueItem(BuildContext context, int index) {
    final patients = [
      'John Doe',
      'Sarah Connor',
      'Kyle Reese',
      'James Wilson',
      'Ellen Ripley',
    ];
    final patient = patients[index % patients.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PrimeCareColors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: PrimeCareColors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PrimeCareColors.skyBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              LucideIcons.user,
              size: 18,
              color: PrimeCareColors.skyBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'Waiting: 15m',
                  style: TextStyle(
                    color: PrimeCareColors.white.withValues(alpha: 0.6),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LucideIcons.plusCircle,
              size: 20,
              color: Colors.white30,
            ),
          ),
        ],
      ),
    );
  }
}
