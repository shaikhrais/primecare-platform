import 'package:primecare_ui/primecare_ui.dart';

class KitchenSinkView extends ConsumerWidget {
  const KitchenSinkView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    
    return OmniConstraintWrapper(
      child: CustomScrollView(
        slivers: [
          // Hero Header
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 40),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(theme.radiusXl),
                gradient: LinearGradient(
                  colors: [
                    theme.colors.primary,
                    theme.colors.primary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colors.primary.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(theme.radiusLg),
                        ),
                        child: const Icon(LucideIcons.sparkles, color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PrimeCare Kitchen Sink',
                              style: theme.typography.h1.copyWith(color: Colors.white, fontSize: 40),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'High-Fidelity Telemetry, Scheduler, & Kanban Board Components',
                              style: theme.typography.bodyLarge.copyWith(color: Colors.white.withValues(alpha: 0.9), fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Scheduler Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(LucideIcons.calendarDays, color: theme.colors.primary),
                  ),
                  const SizedBox(width: 16),
                  Text('Production Scheduler', style: theme.typography.h2),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            sliver: _SchedulerComponent(),
          ),

          // Kanban Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 56.0, bottom: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colors.tertiary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(LucideIcons.layoutDashboard, color: theme.colors.tertiary),
                  ),
                  const SizedBox(width: 16),
                  Text('Governance Workflow Board', style: theme.typography.h2),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            sliver: _KanbanBoardComponent(),
          ),
          
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Scheduler Component
// -----------------------------------------------------------------------------
class _SchedulerComponent extends ConsumerWidget {
  const _SchedulerComponent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(horizonScheduleProvider);

    return scheduleAsync.when(
      data: (schedule) {
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 750, // Wider for timeline view
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            mainAxisExtent: 320, // Fixed height instead of aspect ratio
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final staff = schedule.staff[index];
              return _StaffScheduleCard(staff: staff, schedule: schedule);
            },
            childCount: schedule.staff.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: SizedBox(height: 300, child: Center(child: CircularProgressIndicator())),
      ),
      error: (err, stack) => SliverToBoxAdapter(
        child: SizedBox(height: 300, child: Center(child: Text('Error: $err'))),
      ),
    );
  }
}

class _StaffScheduleCard extends ConsumerWidget {
  final StaffMember staff;
  final HorizonSchedule schedule;

  const _StaffScheduleCard({required this.staff, required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final pressure = ref.watch(staffPressureProvider(staff.id));
    final appointments = schedule.appointments.where((a) => a.staffId == staff.id).toList();

    Color getPressureColor() {
      switch (pressure) {
        case SchedulePressure.critical: return theme.colors.error;
        case SchedulePressure.high: return theme.colors.warning;
        case SchedulePressure.optimal: return Colors.green;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusXl),
        border: Border.all(color: theme.colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: theme.colors.onSurface.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: theme.colors.outlineVariant.withValues(alpha: 0.5))),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                  backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=${staff.id}'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(staff.name, style: theme.typography.h3),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${staff.id} • ${appointments.length} Appointments',
                        style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: getPressureColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: getPressureColor().withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(color: getPressureColor(), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pressure.name.toUpperCase(),
                        style: theme.typography.labelSmall.copyWith(
                          color: getPressureColor(),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Timeline Body
          Expanded(
            child: DragTarget<Appointment>(
              onWillAcceptWithDetails: (details) => details.data.staffId != staff.id,
              onAcceptWithDetails: (details) {
                final appt = details.data;
                ref.read(horizonScheduleProvider.notifier).updateAppointment(
                  appt.copyWith(staffId: staff.id),
                );
              },
              builder: (context, candidateData, rejectedData) {
                final isHovered = candidateData.isNotEmpty;
                return Container(
                  decoration: BoxDecoration(
                    color: isHovered ? theme.colors.primary.withValues(alpha: 0.05) : Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(theme.radiusXl),
                      bottomRight: Radius.circular(theme.radiusXl),
                    ),
                  ),
                  child: appointments.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.calendarX, size: 40, color: theme.colors.onSurfaceVariant.withValues(alpha: 0.3)),
                              const SizedBox(height: 12),
                              Text('No active appointments', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                            ],
                          ),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(24),
                          itemCount: appointments.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final appt = appointments[index];
                            final duration = appt.duration.inMinutes;
                            
                            Widget card;
                            if (appt.isBreak) {
                              card = Container(
                                width: 160,
                                decoration: BoxDecoration(
                                  color: theme.colors.surfaceContainerHighest.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(theme.radiusLg),
                                  border: Border.all(color: theme.colors.outlineVariant, style: BorderStyle.solid),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(LucideIcons.coffee, color: theme.colors.onSurfaceVariant),
                                      const SizedBox(height: 8),
                                      Text('Break', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant, fontWeight: FontWeight.bold)),
                                      Text('${duration}m', style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              card = Container(
                                width: 260,
                                decoration: BoxDecoration(
                                  color: theme.colors.surfaceContainerLowest,
                                  borderRadius: BorderRadius.circular(theme.radiusLg),
                                  border: Border.all(color: theme.colors.outlineVariant),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(theme.radiusLg),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0, top: 0, bottom: 0,
                                        child: Container(width: 6, color: theme.colors.primary),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: theme.colors.primary.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(theme.radiusSm),
                                              ),
                                              child: Text(
                                                '${appt.startTime.hour.toString().padLeft(2, '0')}:${appt.startTime.minute.toString().padLeft(2, '0')} ($duration m)',
                                                style: theme.typography.labelSmall.copyWith(color: theme.colors.primary, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              appt.patientName,
                                              style: theme.typography.h3,
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Icon(LucideIcons.mapPin, size: 14, color: theme.colors.onSurfaceVariant),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    appt.resourceId ?? 'Unassigned',
                                                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return LongPressDraggable<Appointment>(
                              data: appt,
                              hapticFeedbackOnStart: true,
                              feedback: Material(
                                color: Colors.transparent,
                                child: Opacity(
                                  opacity: 0.9,
                                  child: Transform.scale(
                                    scale: 1.05,
                                    child: SizedBox(
                                      width: 300,
                                      child: card,
                                    ),
                                  ),
                                ),
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.3,
                                child: card,
                              ),
                              child: card,
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Kanban Board Component
// -----------------------------------------------------------------------------
class _KanbanBoardComponent extends ConsumerWidget {
  const _KanbanBoardComponent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(horizonScheduleProvider);
    final theme = context.theme;

    return scheduleAsync.when(
      data: (schedule) {
        final now = DateTime.now();
        final upcoming = schedule.appointments.where((a) => a.startTime.isAfter(now)).toList();
        final inProgress = schedule.appointments.where((a) => a.startTime.isBefore(now) && a.endTime.isAfter(now)).toList();
        final completed = schedule.appointments.where((a) => a.endTime.isBefore(now)).toList();

        return SliverToBoxAdapter(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > OmniBreakpoints.tablet;
              
              if (isDesktop) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _KanbanColumn(title: 'UPCOMING', icon: LucideIcons.clock, appointments: upcoming, color: theme.colors.primary)),
                      const SizedBox(width: 32),
                      Expanded(child: _KanbanColumn(title: 'IN PROGRESS', icon: LucideIcons.loader2, appointments: inProgress, color: theme.colors.warning)),
                      const SizedBox(width: 32),
                      Expanded(child: _KanbanColumn(title: 'COMPLETED', icon: LucideIcons.checkCircle2, appointments: completed, color: Colors.green)),
                    ],
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _KanbanColumn(title: 'UPCOMING', icon: LucideIcons.clock, appointments: upcoming, color: theme.colors.primary),
                    const SizedBox(height: 32),
                    _KanbanColumn(title: 'IN PROGRESS', icon: LucideIcons.loader2, appointments: inProgress, color: theme.colors.warning),
                    const SizedBox(height: 32),
                    _KanbanColumn(title: 'COMPLETED', icon: LucideIcons.checkCircle2, appointments: completed, color: Colors.green),
                  ],
                );
              }
            },
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: SizedBox(height: 300, child: Center(child: CircularProgressIndicator()))),
      error: (err, stack) => SliverToBoxAdapter(child: SizedBox(height: 300, child: Center(child: Text('Error: $err')))),
    );
  }
}

class _KanbanColumn extends ConsumerWidget {
  final String title;
  final IconData icon;
  final List<Appointment> appointments;
  final Color color;

  const _KanbanColumn({required this.title, required this.icon, required this.appointments, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return DragTarget<Appointment>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) {
        final appointment = details.data;
        final now = DateTime.now();
        final duration = appointment.endTime.difference(appointment.startTime);
        
        DateTime newStart;
        DateTime newEnd;

        if (title == 'COMPLETED') {
          newEnd = now.subtract(const Duration(minutes: 1));
          newStart = newEnd.subtract(duration);
        } else if (title == 'IN PROGRESS') {
          newStart = now.subtract(Duration(minutes: duration.inMinutes ~/ 2));
          newEnd = newStart.add(duration);
        } else {
          // UPCOMING
          newStart = now.add(const Duration(minutes: 1));
          newEnd = newStart.add(duration);
        }

        final updatedAppt = appointment.copyWith(
          startTime: newStart,
          endTime: newEnd,
        );

        ref.read(horizonScheduleProvider.notifier).updateAppointment(updatedAppt);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isHovering 
                ? color.withValues(alpha: 0.05) 
                : theme.colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(theme.radiusXl),
            border: Border.all(
              color: isHovering ? color : theme.colors.outlineVariant,
              width: isHovering ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Column Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: isHovering ? color : theme.colors.outlineVariant, width: 2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 20, color: color),
                        const SizedBox(width: 12),
                        Text(title, style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        appointments.length.toString(),
                        style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold, color: color),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Column Body
              appointments.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.inbox, size: 48, color: theme.colors.onSurfaceVariant.withValues(alpha: 0.2)),
                            const SizedBox(height: 16),
                            Text('No active items', style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      itemCount: appointments.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final appt = appointments[index];
                        return _KanbanCard(appointment: appt, color: color);
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _KanbanCard extends StatelessWidget {
  final Appointment appointment;
  final Color color;

  const _KanbanCard({required this.appointment, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final duration = appointment.endTime.difference(appointment.startTime).inMinutes;

    final card = Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusLg),
        border: Border.all(color: theme.colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: theme.colors.onSurface.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(theme.radiusLg),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        appointment.patientName,
                        style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(theme.radiusSm),
                      ),
                      child: Text(
                        '${duration}m',
                        style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.clock, size: 16, color: color),
                      const SizedBox(width: 8),
                      Text(
                        '${appointment.startTime.hour.toString().padLeft(2, '0')}:${appointment.startTime.minute.toString().padLeft(2, '0')} - ${appointment.endTime.hour.toString().padLeft(2, '0')}:${appointment.endTime.minute.toString().padLeft(2, '0')}',
                        style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                      child: Icon(LucideIcons.user, size: 12, color: theme.colors.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appointment.resourceId ?? 'Unassigned',
                        style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return LongPressDraggable<Appointment>(
      data: appointment,
      hapticFeedbackOnStart: true,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(
          opacity: 0.9,
          child: Transform.scale(
            scale: 1.05,
            child: SizedBox(
              width: 350, // Approximate width for visual feedback
              child: card,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: card,
      ),
      child: card,
    );
  }
}
