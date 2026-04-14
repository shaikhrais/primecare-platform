import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HorizonGrid extends ConsumerWidget {
  final HorizonSchedule schedule;

  const HorizonGrid({super.key, required this.schedule});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(executionGateProvider).passGate(
      ExecutionGateCategory.scheduler,
      'Rendering Horizon Grid (Staff: ${schedule.staff.length}, Appts: ${schedule.appointments.length})',
    );
    const double hourHeight = 120.0;
    const double staffWidth = 220.0;
    const int startHour = 8;
    const int endHour = 20;

    final auraPulse = ref.watch(auraPulseProvider).value;

    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                // Time Labels (Fixed Column)
                Container(
                  width: 60,
                  color: Theme.of(context).cardColor.withValues(alpha: 0.5),
                  child: Column(
                    children: [
                      const SizedBox(height: 80), // Header spacer
                      for (int h = startHour; h <= endHour; h++)
                        Container(
                          height: hourHeight,
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${h == 12 ? 12 : h % 12} ${h >= 12 ? 'PM' : 'AM'}',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Colors.white60),
                          ),
                        ),
                    ],
                  ),
                ),

                // Staff Columns
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    children: schedule.staff.map((staff) {
                      final pressure = ref.watch(
                        staffPressureProvider(staff.id),
                      );
                      
                      final isAuraTarget = auraPulse?.metadata?['staffId'] == staff.id || 
                         (auraPulse != null && auraPulse.description.toLowerCase().contains(staff.name.toLowerCase()));

                      return _StaffColumn(
                        staff: staff,
                        pressure: pressure,
                        isAuraTarget: isAuraTarget,
                        resources: schedule.resources,
                        appointments: schedule.appointments
                            .where((a) => a.staffId == staff.id)
                            .toList(),
                        hourHeight: hourHeight,
                        staffWidth: staffWidth,
                        startHour: startHour,
                        endHour: endHour,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StaffColumn extends ConsumerWidget {
  final StaffMember staff;
  final SchedulePressure pressure;
  final bool isAuraTarget;
  final List<InstitutionalResource> resources;
  final List<Appointment> appointments;
  final double hourHeight;
  final double staffWidth;
  final int startHour;
  final int endHour;

  const _StaffColumn({
    required this.staff,
    required this.pressure,
    required this.isAuraTarget,
    required this.resources,
    required this.appointments,
    required this.hourHeight,
    required this.staffWidth,
    required this.startHour,
    required this.endHour,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pressureColor = _getPressureColor(pressure);

    return Container(
      width: staffWidth,
      decoration: BoxDecoration(
        color: isAuraTarget ? Colors.indigoAccent.withValues(alpha: 0.1) : null,
        border: Border(
          right: BorderSide(
            color: isAuraTarget 
                ? Colors.indigoAccent.withValues(alpha: 0.4) 
                : Colors.white.withValues(alpha: 0.05),
            width: isAuraTarget ? 2 : 1,
          ),
          left: isAuraTarget ? BorderSide(color: Colors.indigoAccent.withValues(alpha: 0.4), width: 2) : BorderSide.none,
        ),
      ),
      child: Column(
        children: [
          // Staff Header
          _StaffHeader(staff: staff, pressure: pressure, color: pressureColor, isAuraTarget: isAuraTarget),

          // Appointments Stack
          Expanded(
            child: Stack(
              children: [
                // Background Grid Lines
                for (int h = startHour; h <= endHour; h++)
                  Container(
                    height: hourHeight,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.03),
                        ),
                      ),
                    ),
                  ),

                // Appointment Cards
                ...appointments.map((appt) {
                  try {
                    final top = _calculateOffset(
                      appt.startTime,
                      startHour,
                      hourHeight,
                    );
                      final height = (appt.duration.inMinutes / 60.0) * hourHeight;
                    
                    if (top.isNaN || height.isNaN || top < 0 || height < 0) {
                      ref.read(executionGateProvider).failGate(
                        ExecutionGateCategory.scheduler,
                        'Invalid Appointment Layout for appt_id: ${appt.id}',
                        metadata: {'top': top, 'height': height},
                      );
                      throw Exception('Invalid layout measurement');
                    }

                    return Positioned(
                      top: top,
                      left: 8,
                      right: 8,
                      height: height,
                      child: _AppointmentCard(
                        appointment: appt,
                        color: staff.themeColor,
                        resourceName: appt.resourceId != null
                            ? resources
                                  .firstWhere(
                                    (r) => r.id == appt.resourceId,
                                    orElse: () => InstitutionalResource(
                                      id: '',
                                      name: 'Unknown',
                                      type: ResourceType.room,
                                    ),
                                  )
                                  .name
                            : null,
                      ),
                    );
                  } catch (e) {
                    // Checkpoint: Gracefully hide corrupted appointment layout
                    return const SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateOffset(DateTime time, int startHour, double hourHeight) {
    final hourPart = time.hour - startHour;
    final minPart = time.minute / 60.0;
    return (hourPart + minPart) * hourHeight;
  }

  Color _getPressureColor(SchedulePressure pressure) {
    switch (pressure) {
      case SchedulePressure.critical:
        return Colors.redAccent;
      case SchedulePressure.high:
        return Colors.orangeAccent;
      default:
        return Colors.greenAccent;
    }
  }
}

class _StaffHeader extends StatelessWidget {
  final StaffMember staff;
  final SchedulePressure pressure;
  final Color color;
  final bool isAuraTarget;

  const _StaffHeader({
    required this.staff,
    required this.pressure,
    required this.color,
    this.isAuraTarget = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.3),
        border: Border(
          bottom: BorderSide(
            color: isAuraTarget ? Colors.indigoAccent : color.withValues(alpha: 0.5), 
            width: isAuraTarget ? 3 : 2
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(staff.avatarUrl),
            backgroundColor: isAuraTarget ? Colors.indigoAccent : staff.themeColor.withValues(alpha: 0.2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  staff.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  staff.specialization,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (pressure != SchedulePressure.optimal)
            Icon(LucideIcons.flame, color: color, size: 16),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final Color color;
  final String? resourceName;

  const _AppointmentCard({
    required this.appointment,
    required this.color,
    this.resourceName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  appointment.patientName,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (resourceName != null)
                Icon(
                  resourceName!.contains('Room')
                      ? LucideIcons.home
                      : LucideIcons.zap,
                  size: 10,
                  color: Colors.white60,
                ),
            ],
          ),
          if (appointment.duration.inMinutes >= 30) ...[
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                appointment.note ?? 'Standard Treatment',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
          if (resourceName != null)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                resourceName!,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
