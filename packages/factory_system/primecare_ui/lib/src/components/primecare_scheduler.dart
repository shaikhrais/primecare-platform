// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

import 'package:primecare_ui/src/theme/design_system.dart';

class PrimeCareSchedulerEvent {
  final String id;
  final String title;
  final String subtitle;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;

  const PrimeCareSchedulerEvent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
  });
}

class PrimeCareScheduler extends StatelessWidget {
  final DateTime activeDate;
  final List<PrimeCareSchedulerEvent> events;
  final double hourHeight;
  final int startHour;
  final int endHour;
  final void Function(PrimeCareSchedulerEvent)? onEventTap;

  const PrimeCareScheduler({
    super.key,
    required this.activeDate,
    required this.events,
    this.hourHeight = 80.0,
    this.startHour = 6, // default 6 AM
    this.endHour = 22, // default 10 PM
    this.onEventTap,
  });

  double _calculateTop(DateTime time) {
    final activeHour = time.hour - startHour;
    return (activeHour * hourHeight) + (time.minute / 60.0 * hourHeight);
  }

  double _calculateHeight(DateTime start, DateTime end) {
    final diff = end.difference(start).inMinutes;
    return (diff / 60.0) * hourHeight;
  }

  @override
  Widget build(BuildContext context) {
    final totalHours = endHour - startHour;

    return Container(
      decoration: BoxDecoration(
        color: PrimeCareDesignSystem.surfaceElevated,
        borderRadius: PrimeCareRadii.boardLg,
        border: Border.all(color: PrimeCareDesignSystem.borderSubtle),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: totalHours * hourHeight,
          child: Stack(
            children: [
              // 1. Render the Background Y-Axis Grids
              for (int i = 0; i <= totalHours; i++)
                Positioned(
                  top: i * hourHeight,
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: PrimeCareSpacing.md,
                            top: PrimeCareSpacing.xs,
                          ),
                          child: Text(
                            '${(startHour + i).toString().padLeft(2, '0')}:00',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: PrimeCareDesignSystem.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: PrimeCareDesignSystem.borderSubtle,
                          height: 1,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                ),

              // 2. Render the specific Shift/Action Blocks natively
              for (final event in events)
                if (event.startTime.year == activeDate.year &&
                    event.startTime.month == activeDate.month &&
                    event.startTime.day == activeDate.day)
                  Positioned(
                    top: _calculateTop(event.startTime),
                    left: 70, // Margin past the time axis
                    right: PrimeCareSpacing.md,
                    height: _calculateHeight(
                      event.startTime,
                      event.endTime,
                    ).clamp(24.0, double.infinity), // never smaller than 24
                    child: GestureDetector(
                      onTap: onEventTap != null
                          ? () => onEventTap!(event)
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: PrimeCareSpacing.sm,
                          vertical: PrimeCareSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: event.isCompleted
                              ? PrimeCareDesignSystem.successSurface
                              : const Color(
                                  0xFFE0F2FE,
                                ), // Hardcoded subtle blue logic layer
                          borderRadius: PrimeCareRadii.boardSm,
                          border: Border(
                            left: BorderSide(
                              color: event.isCompleted
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF38BDF8),
                              width: 4,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              event.title,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF0F172A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (_calculateHeight(
                                  event.startTime,
                                  event.endTime,
                                ) >=
                                50)
                              Text(
                                event.subtitle,
                                style: TextStyle(
                                  color: const Color(0xFF334155),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
