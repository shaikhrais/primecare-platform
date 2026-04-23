// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/components/scheduler/01_I_prime_care_multi_staff_grid.dart';
import 'package:primecare_ui/src/components/scheduler/01_I_institutional_booking_dialog.dart';

class InstitutionalSchedulerScreen extends ConsumerStatefulWidget {
  const InstitutionalSchedulerScreen({super.key});

  @override
  ConsumerState<InstitutionalSchedulerScreen> createState() =>
      _InstitutionalSchedulerScreenState();
}

class _InstitutionalSchedulerScreenState
    extends ConsumerState<InstitutionalSchedulerScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _showResources = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(auraContextProvider.notifier).update('Institutional Scheduler');
    });
  }

  Future<void> _handleNewAppointment(BuildContext context) async {
    final scheduleAsync = ref.read(horizonScheduleProvider);
    scheduleAsync.whenData((schedule) async {
      final result = await showDialog<dynamic>(
        context: context,
        builder: (context) => InstitutionalBookingDialog(
          schedule: schedule,
          initialDate: _selectedDate,
          showResources: _showResources,
        ),
      );

      if (result is Appointment) {
        try {
          await ref
              .read(horizonScheduleProvider.notifier)
              .addAppointment(result);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment Created'),
                backgroundColor: PrimeCareColors.emerald,
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Creation Failed: $e'),
                backgroundColor: PrimeCareColors.rose,
              ),
            );
          }
        }
      }
    });
  }

  Future<void> _handleEditAppointment(Appointment appt) async {
    final scheduleAsync = ref.read(horizonScheduleProvider);
    scheduleAsync.whenData((schedule) async {
      final result = await showDialog<dynamic>(
        context: context,
        builder: (context) => InstitutionalBookingDialog(
          schedule: schedule,
          initialDate: appt.startTime,
          showResources: _showResources,
          initialAppointment: appt,
        ),
      );

      if (!mounted) return;

      if (result == 'delete') {
        try {
          await ref
              .read(horizonScheduleProvider.notifier)
              .deleteAppointment(appt.id);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment deleted'),
                backgroundColor: PrimeCareColors.rose,
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
                backgroundColor: PrimeCareColors.rose,
              ),
            );
          }
        }
      } else if (result is Appointment) {
        try {
          final updated = result.copyWith(id: appt.id);
          await ref
              .read(horizonScheduleProvider.notifier)
              .updateAppointment(updated);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment updated'),
                backgroundColor: PrimeCareColors.emerald,
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
                backgroundColor: PrimeCareColors.rose,
              ),
            );
          }
        }
      }
    });
  }

  Future<void> _handleMoveAppointment(
    Appointment appt,
    DateTime newTime,
    String newStaffId,
  ) async {
    try {
      final updated = appt.copyWith(startTime: newTime, staffId: newStaffId);

      await ref
          .read(horizonScheduleProvider.notifier)
          .updateAppointment(updated);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Appointment moved to ${newTime.hour}:${newTime.minute.toString().padLeft(2, '0')}',
            ),
            backgroundColor: PrimeCareDesignSystem.primaryBrand,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Move Failed: $e'),
            backgroundColor: PrimeCareColors.rose,
          ),
        );
      }
    }
  }

  void _handleSlotSelected(StaffMember staff, DateTime time) async {
    final scheduleAsync = ref.read(horizonScheduleProvider);
    scheduleAsync.whenData((schedule) async {
      final result = await showDialog<dynamic>(
        context: context,
        builder: (context) => InstitutionalBookingDialog(
          schedule: schedule,
          initialDate: time,
          showResources: _showResources,
          initialStaff: staff,
        ),
      );

      if (result is Appointment) {
        try {
          await ref
              .read(horizonScheduleProvider.notifier)
              .addAppointment(result);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment Created'),
                backgroundColor: PrimeCareColors.emerald,
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Creation Failed: $e'),
                backgroundColor: PrimeCareColors.rose,
              ),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleAsync = ref.watch(horizonScheduleProvider);
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          scheduleAsync.when(
            data: (schedule) => _buildBody(context, schedule, scale),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Scheduler Error: $e')),
          ),
          // Aura AI HUD Overlay
          Positioned(
            bottom: 24 * scale,
            right: 24 * scale,
            child: Consumer(
              builder: (context, ref, child) {
                final anomalies = ref.watch(schedulerAnomalyProvider);
                if (anomalies.isEmpty) return const SizedBox.shrink();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final anomaly in anomalies.take(3))
                      Padding(
                        padding: EdgeInsets.only(bottom: 12 * scale),
                        child: AuraInsightCard(
                          event: anomaly,
                          onDismiss: () {
                            // In a real app, we'd mute this specific insight
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleNewAppointment(context),
        label: const Text('New Appointment'),
        icon: const Icon(LucideIcons.plus),
        backgroundColor: PrimeCareDesignSystem.primaryBrand,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    HorizonSchedule schedule,
    double scale,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Strip
        _buildHeader(context, scale),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24 * scale),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Scheduler Grid
                Expanded(
                  flex: 3,
                  child: PrimeCareMultiStaffGrid(
                    staff: schedule.staff,
                    appointments: schedule.appointments,
                    resources: schedule.resources,
                    selectedDate: _selectedDate,
                    showResources: _showResources,
                    onAppointmentMoved: _handleMoveAppointment,
                    onSlotSelected: _handleSlotSelected,
                    onAppointmentTap: _handleEditAppointment,
                  ),
                ),
                if (_showResources) ...[
                  SizedBox(width: 24 * scale),
                  // Resource Status Panel
                  Expanded(
                    flex: 1,
                    child: _buildResourcePanel(
                      context,
                      schedule.resources,
                      scale,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 24 * scale),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, double scale) {
    return Padding(
      padding: EdgeInsets.all(24 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Institutional Scheduler',
                style: TextStyle(
                  fontSize: 24 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
              Text(
                'Centralized staff and resource management',
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildViewToggle(scale),
              SizedBox(width: 16 * scale),
              _buildDateSelector(scale),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle(double scale) {
    return Container(
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: PrimeCareRadii.scaled(scale),
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Row(
        children: [
          _toggleItem(
            icon: LucideIcons.users,
            isActive: !_showResources,
            onTap: () => setState(() => _showResources = false),
            scale: scale,
          ),
          _toggleItem(
            icon: LucideIcons.layout,
            isActive: _showResources,
            onTap: () => setState(() => _showResources = true),
            scale: scale,
          ),
        ],
      ),
    );
  }

  Widget _toggleItem({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
    required double scale,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8 * scale),
        decoration: BoxDecoration(
          color: isActive
              ? PrimeCareDesignSystem.primaryBrand.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: PrimeCareRadii.scaled(scale),
        ),
        child: Icon(
          icon,
          size: 18 * scale,
          color: isActive
              ? PrimeCareDesignSystem.primaryBrand
              : PrimeCareColors.slate400,
        ),
      ),
    );
  }

  Widget _buildDateSelector(double scale) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 8 * scale,
      ),
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: PrimeCareRadii.scaled(scale),
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left, size: 20 * scale),
            onPressed: () => setState(
              () => _selectedDate = _selectedDate.subtract(
                const Duration(days: 1),
              ),
            ),
          ),
          Text(
            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14 * scale),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, size: 20 * scale),
            onPressed: () => setState(
              () => _selectedDate = _selectedDate.add(const Duration(days: 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcePanel(
    BuildContext context,
    List<InstitutionalResource> resources,
    double scale,
  ) {
    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: PrimeCareColors.white,
        borderRadius: PrimeCareRadii.scaled(scale),
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.database,
                size: 18 * scale,
                color: const Color(0xFF1E3A8A),
              ),
              SizedBox(width: 12 * scale),
              Text(
                'Resource Status',
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Expanded(
            child: ListView.separated(
              itemCount: resources.length,
              separatorBuilder: (context, _) => SizedBox(height: 16 * scale),
              itemBuilder: (context, index) {
                final res = resources[index];
                return _buildResourceItem(res, scale);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceItem(InstitutionalResource res, double scale) {
    Color statusColor;
    IconData statusIcon;

    switch (res.status) {
      case ResourceStatus.available:
        statusColor = PrimeCareColors.emerald;
        statusIcon = LucideIcons.checkCircle2;
        break;
      case ResourceStatus.busy:
        statusColor = PrimeCareColors.amber;
        statusIcon = LucideIcons.activity;
        break;
      case ResourceStatus.maintenance:
        statusColor = PrimeCareColors.skyBlue;
        statusIcon = LucideIcons.wrench;
        break;
      case ResourceStatus.offline:
        statusColor = PrimeCareColors.rose;
        statusIcon = LucideIcons.alertTriangle;
        break;
    }

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8 * scale),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(statusIcon, size: 16 * scale, color: statusColor),
        ),
        SizedBox(width: 12 * scale),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                res.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13 * scale,
                ),
              ),
              Text(
                res.type.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 10 * scale,
                  color: PrimeCareColors.slate400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
