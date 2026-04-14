import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
import '../../theme/design_system.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrimeCareMultiStaffGrid extends ConsumerWidget {
  final List<StaffMember> staff;
  final List<Appointment> appointments;
  final List<InstitutionalResource> resources;
  final DateTime selectedDate;
  final bool showResources;
  final Function(Appointment appt, DateTime newTime, String newStaffId)?
  onAppointmentMoved;
  final Function(StaffMember staff, DateTime time)? onSlotSelected;
  final Function(Appointment appt)? onAppointmentTap;

  const PrimeCareMultiStaffGrid({
    super.key,
    required this.staff,
    required this.appointments,
    required this.resources,
    required this.selectedDate,
    this.showResources = true,
    this.onAppointmentMoved,
    this.onSlotSelected,
    this.onAppointmentTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final scale = layout.scaleFactor;

    // Time slots from 8 AM to 6 PM
    final startHour = 8;
    final endHour = 18;
    final slotDuration = const Duration(minutes: 30);
    final totalSlots = ((endHour - startHour) * 60 / slotDuration.inMinutes)
        .floor();

    ref.read(executionGateProvider).passGate(
      ExecutionGateCategory.scheduler,
      'Rendering MultiStaffGrid: ${staff.length} staff, ${appointments.length} appointments',
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: PrimeCareRadii.scaled(scale),
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: Column(
        children: [
          // Header Row: Staff Names
          _buildStaffHeader(context, scale),
          const Divider(height: 1),
          // Scrollable Grid Area
          Expanded(
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    // Time Axis
                    _buildTimeAxis(
                      context,
                      scale,
                      startHour,
                      totalSlots,
                      slotDuration,
                    ),
                    const VerticalDivider(width: 1),
                    // Main Grid
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: _buildGridBody(
                          context,
                          scale,
                          startHour,
                          totalSlots,
                          slotDuration,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffHeader(BuildContext context, double scale) {
    return Padding(
      padding: EdgeInsets.only(left: 80 * scale), // Offset for time axis
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: staff
              .map((s) => _buildStaffColumnHeader(s, scale))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildStaffColumnHeader(StaffMember staff, double scale) {
    return Container(
      width: 200 * scale,
      padding: EdgeInsets.all(12 * scale),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: PrimeCareDesignSystem.borderSubtle),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16 * scale,
            backgroundColor: staff.themeColor.withValues(alpha: 0.2),
            child: Text(
              staff.name[0],
              style: TextStyle(
                color: staff.themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 12 * scale,
              ),
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13 * scale,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  staff.specialization,
                  style: TextStyle(fontSize: 11 * scale, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeAxis(
    BuildContext context,
    double scale,
    int startHour,
    int totalSlots,
    Duration slotDuration,
  ) {
    return SizedBox(
      width: 80 * scale,
      child: Column(
        children: List.generate(totalSlots, (index) {
          final time = DateTime(
            2024,
            1,
            1,
            startHour,
          ).add(slotDuration * index);
          final hour = time.hour.toString().padLeft(2, '0');
          final minute = time.minute.toString().padLeft(2, '0');

          return Container(
            height: 60 * scale,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 8 * scale),
            child: Text(
              '$hour:$minute',
              style: TextStyle(
                fontSize: 12 * scale,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildGridBody(
    BuildContext context,
    double scale,
    int startHour,
    int totalSlots,
    Duration slotDuration,
  ) {
    return Row(
      children: staff
          .map(
            (s) => _buildStaffColumn(
              context,
              s,
              scale,
              startHour,
              totalSlots,
              slotDuration,
            ),
          )
          .toList(),
    );
  }

  Widget _buildStaffColumn(
    BuildContext context,
    StaffMember s,
    double scale,
    int startHour,
    int totalSlots,
    Duration slotDuration,
  ) {
    final staffAppointments = appointments
        .where((a) => a.staffId == s.id)
        .toList();

    return Container(
      width: 200 * scale,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: PrimeCareDesignSystem.borderSubtle),
        ),
      ),
      child: Stack(
        children: [
          // Background Grid Lines + DragTargets
          Column(
            children: List.generate(totalSlots, (index) {
              final slotTime = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                startHour,
              ).add(slotDuration * index);

              return DragTarget<Appointment>(
                onWillAcceptWithDetails: (details) => appointments.every(
                  (a) =>
                      a.id == details.data.id ||
                      (a.staffId != s.id ||
                          !a.overlaps(
                            details.data.copyWith(startTime: slotTime),
                          )),
                ),
                onAcceptWithDetails: (details) =>
                    onAppointmentMoved?.call(details.data, slotTime, s.id),
                builder: (context, candidateData, rejectedData) {
                  final isHovered = candidateData.isNotEmpty;

                  return GestureDetector(
                    onTap: () {
                      onSlotSelected?.call(s, slotTime);
                    },
                    child: Container(
                      height: 60 * scale,
                      decoration: BoxDecoration(
                        color: isHovered
                            ? s.themeColor.withValues(alpha: 0.1)
                            : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          // Appointment Blocks
          ...staffAppointments.map(
            (appt) => _buildAppointmentBlock(
              context,
              appt,
              scale,
              startHour,
              slotDuration,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentBlock(
    BuildContext context,
    Appointment appt,
    double scale,
    int startHour,
    Duration slotDuration,
  ) {
    final startMinutes =
        appt.startTime.hour * 60 + appt.startTime.minute - (startHour * 60);
    final top = (startMinutes / slotDuration.inMinutes) * 60.0 * scale;
    final height =
        (appt.duration.inMinutes / slotDuration.inMinutes) * 60.0 * scale;

    final resource = resources.firstWhere(
      (r) => r.id == appt.resourceId,
      orElse: () =>
          InstitutionalResource(id: '', name: 'N/A', type: ResourceType.room),
    );

    return Positioned(
      top: top,
      left: 4 * scale,
      right: 4 * scale,
      height: height - (2 * scale),
      child: Draggable<Appointment>(
        data: appt,
        feedback: Material(
          child: _buildBlockContainer(appt, scale, height, resource, true),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: _buildBlockContainer(appt, scale, height, resource, false),
        ),
        child: GestureDetector(
          onTap: () => onAppointmentTap?.call(appt),
          child: _buildBlockContainer(appt, scale, height, resource, false),
        ),
      ),
    );
  }

  Widget _buildBlockContainer(
    Appointment appt,
    double scale,
    double height,
    InstitutionalResource resource,
    bool isFeedback,
  ) {
    return Container(
      width: isFeedback ? 180 * scale : null, // Fixed width for feedback
      padding: EdgeInsets.all(8 * scale),
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.primaryBrand.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8 * scale),
        border: Border.all(
          color: PrimeCareDesignSystem.primaryBrand.withValues(alpha: 0.3),
        ),
        boxShadow: isFeedback
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10 * scale,
                  offset: Offset(0, 5 * scale),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  appt.patientName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11 * scale,
                    color: PrimeCareDesignSystem.primaryBrand,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                LucideIcons.clock,
                size: 10 * scale,
                color: PrimeCareDesignSystem.primaryBrand,
              ),
            ],
          ),
          if (showResources && height > 40 * scale) ...[
            SizedBox(height: 4 * scale),
            Row(
              children: [
                Icon(
                  LucideIcons.mapPin,
                  size: 10 * scale,
                  color: Colors.grey[700],
                ),
                SizedBox(width: 4 * scale),
                Expanded(
                  child: Text(
                    resource.name,
                    style: TextStyle(
                      fontSize: 10 * scale,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
