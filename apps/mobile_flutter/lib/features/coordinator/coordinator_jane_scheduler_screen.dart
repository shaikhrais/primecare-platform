import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorJaneSchedulerScreen extends StatefulWidget {
  const CoordinatorJaneSchedulerScreen({super.key});

  @override
  State<CoordinatorJaneSchedulerScreen> createState() =>
      _CoordinatorJaneSchedulerScreenState();
}

class _CoordinatorJaneSchedulerScreenState
    extends State<CoordinatorJaneSchedulerScreen> {
  final double _hourHeight = 100.0;
  final double _columnWidth = 220.0;
  final double _timeColumnWidth = 60.0;
  final int _startHour = 7; // 07:00 AM
  final int _endHour = 20; // 08:00 PM

  // The Top Axis list of resources / workers
  final List<Map<String, dynamic>> _providers = [
    {'id': 'RN-1', 'name': 'Eliza Thornberry', 'role': 'RN'},
    {'id': 'PSW-1', 'name': 'Sarah Jenkins', 'role': 'PSW'},
    {'id': 'PSW-2', 'name': 'Marcus Vance', 'role': 'PSW'},
    {'id': 'PSW-3', 'name': 'Julia Roberts', 'role': 'PSW'},
  ];

  // Mathematical Schedule Blocks
  final List<Map<String, dynamic>> _scheduleBlocks = [
    {
      'provider': 'RN-1',
      'start': 8.0,
      'duration': 1.5,
      'client': 'A. Pendelton',
      'type': 'Wound Care',
      'state': 'arrived',
    },
    {
      'provider': 'RN-1',
      'start': 10.0,
      'duration': 2.0,
      'client': 'M. Atwood',
      'type': 'Assessment',
      'state': 'scheduled',
    },
    {
      'provider': 'PSW-1',
      'start': 7.5,
      'duration': 3.0,
      'client': 'J. Smith',
      'type': 'Complex Care',
      'state': 'completed',
    },
    {
      'provider': 'PSW-2',
      'start': 9.0,
      'duration': 4.0,
      'client': 'G. Harrison',
      'type': 'Companionship',
      'state': 'en_route',
    },
    {
      'provider': 'PSW-2',
      'start': 14.0,
      'duration': 2.5,
      'client': 'S. Croft',
      'type': 'Physical Support',
      'state': 'scheduled',
    },
    {
      'provider': 'PSW-3',
      'start': 8.0,
      'duration': 8.0,
      'client': 'Auto-Max Sequence',
      'type': 'Utilization',
      'state': 'auto',
    },
  ];

  // Waitlisted shifts
  final List<Map<String, dynamic>> _waitlist = [
    {
      'client': 'H. Potter',
      'type': 'Standard Intake',
      'duration': 1.0,
      'state': 'scheduled',
    },
    {
      'client': 'R. Weasley',
      'type': 'Physical Check',
      'duration': 2.0,
      'state': 'scheduled',
    },
  ];

  Color _getStateColor(String state) {
    switch (state) {
      case 'completed':
        return PrimeCareColors.slate500; // Slate Grey
      case 'arrived':
        return PrimeCareColors.emerald; // Emerald Green
      case 'en_route':
        return PrimeCareColors.amber; // Amber Warning
      case 'scheduled':
        return Color(0xFF3B82F6); // Standard Blue
      case 'auto':
        return PrimeCareColors.purple; // AI Purple
      case 'no_show':
        return PrimeCareColors.rose; // Red
      default:
        return PrimeCareColors.slate200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Colors.white,

      body: PrimeCareRow(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==== GHOST SIDECAR (WAITLIST) ====
          PrimeCareCard(
            width: 200,

            child: PrimeCareColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PrimeCarePadding(
                  padding: EdgeInsets.all(16.0),
                  child: PrimeCareText(
                    'Waitlist Array',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: PrimeCareColors.slate500,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                PrimeCareExpanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _waitlist.length,
                    itemBuilder: (context, index) {
                      final item = _waitlist[index];
                      return PrimeCarePadding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Draggable<Map<String, dynamic>>(
                          data: item,
                          feedback: Material(
                            color: Colors.transparent,
                            child: _buildShiftCard(item, opacity: 0.8),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.3,
                            child: _buildShiftCard(item),
                          ),
                          child: _buildShiftCard(item),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Y-Axis Time Static Column
          SizedBox(
            width: _timeColumnWidth,
            child: PrimeCareColumn(
              children: [
                PrimeCareCard(
                  height: 50,
                  child: const SizedBox.shrink(),
                ), // Corner Block
                PrimeCareExpanded(
                  child: ListView.builder(
                    itemCount: _endHour - _startHour + 1,
                    physics:
                        ClampingScrollPhysics(), // Match scroll later if synced, but usually interactive viewer handles inner body
                    itemBuilder: (context, index) {
                      final time = _startHour + index;
                      final String amPm = time >= 12 ? 'PM' : 'AM';
                      final int displayTime = time > 12 ? time - 12 : time;
                      return PrimeCareCard(
                        height: _hourHeight,

                        child: PrimeCareCenter(
                          child: PrimeCareText(
                            '$displayTime:00 $amPm',
                            style: TextStyle(
                              color: PrimeCareColors.slate400,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // The 2D Scrolling Matrix payload
          PrimeCareExpanded(
            child: InteractiveViewer(
              constrained:
                  false, // Allows X and Y infinite panning mathematically
              boundaryMargin: EdgeInsets.all(0),
              minScale: 0.5,
              maxScale: 2.0,
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // X-Axis Provider Static Headers
                  PrimeCareRow(
                    children: _providers
                        .map(
                          (p) => PrimeCareCard(
                            width: _columnWidth,
                            height: 50,

                            child: PrimeCareCenter(
                              child: PrimeCareColumn(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PrimeCareText(
                                    p['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: PrimeCareColors.radarDark,
                                      fontSize: 14,
                                    ),
                                  ),
                                  PrimeCareText(
                                    '${p['role']} • Active',
                                    style: TextStyle(
                                      color: PrimeCareColors.emerald,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  // The Timeline Physical Grid
                  SizedBox(
                    height: (_endHour - _startHour + 1) * _hourHeight,
                    width: _providers.length * _columnWidth,
                    child: PrimeCareStack(
                      children: [
                        // Background Grid Lines Layout
                        ...List.generate(_endHour - _startHour + 1, (y) {
                          return Positioned(
                            top: y * _hourHeight,
                            left: 0,
                            right: 0,
                            child: PrimeCareContainer(
                              height: 1,
                              color: Color(0xFFF1F5F9),
                            ),
                          );
                        }),
                        ...List.generate(_providers.length, (x) {
                          return Positioned(
                            top: 0,
                            bottom: 0,
                            left: x * _columnWidth,
                            child: PrimeCareContainer(
                              width: 1,
                              color: Color(0xFFF1F5F9),
                            ),
                          );
                        }),

                        // Shift Block Overlays
                        ..._scheduleBlocks.map((block) {
                          final providerIndex = _providers.indexWhere(
                            (p) => p['id'] == block['provider'],
                          );
                          if (providerIndex == -1) return SizedBox.shrink();

                          final double topOffset =
                              (block['start'] - _startHour) * _hourHeight;
                          final double blockHeight =
                              block['duration'] * _hourHeight;
                          final Color blockColor = _getStateColor(
                            block['state'],
                          );

                          return Positioned(
                            left:
                                providerIndex * _columnWidth + 4, // 4px padding
                            width: _columnWidth - 8,
                            top: topOffset,
                            height: blockHeight,
                            child: PrimeCareCard(
                              padding: EdgeInsets.all(12),

                              child: PrimeCareColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimeCareRow(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      PrimeCareText(
                                        block['client'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: blockColor.withAlpha(200),
                                          fontSize: 14,
                                        ),
                                      ),
                                      PrimeCareIcon(
                                        Icons.check_circle,
                                        size: 14,
                                        color: blockColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  PrimeCareText(
                                    block['type'],
                                    style: TextStyle(
                                      color: Color(0xFF475569),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        // Waitlist Dropping DragTarget Layout Matrix
                        ...List.generate(_providers.length, (x) {
                          return Positioned(
                            left: x * _columnWidth,
                            top: 0,
                            bottom: 0,
                            width: _columnWidth,
                            child: DragTarget<Map<String, dynamic>>(
                              builder: (context, candidateData, rejectedData) {
                                return PrimeCareContainer(
                                  color: candidateData.isNotEmpty
                                      ? Color(0x1110B981)
                                      : Colors.transparent,
                                );
                              },
                              onAcceptWithDetails: (details) {
                                // Mathematical algorithm extracting Y Drop Constraints relative to Time Interval
                                final droppedItem = details.data;

                                // Calculate the dropped hour roughly based on Local Offset
                                // Assuming drop offset directly to InteractiveViewer Stack (Scale=1.0)
                                // Standard offset maps directly because DragTarget is sized identically.
                                final double localY =
                                    details.offset.dy -
                                    100; // Account for AppBar + Heuristic offsets
                                double calculatedHour =
                                    (localY / _hourHeight).floorToDouble() +
                                    _startHour;
                                if (calculatedHour < _startHour)
                                  calculatedHour = _startHour.toDouble();

                                // Aggressive Double Booking Hardware Trap
                                final String targetProvider =
                                    _providers[x]['id'];
                                bool collision = false;
                                for (var block in _scheduleBlocks) {
                                  if (block['provider'] == targetProvider) {
                                    final endHour =
                                        block['start'] + block['duration'];
                                    final dropEndHour =
                                        calculatedHour +
                                        droppedItem['duration'];
                                    // Overlap logic: StartA < EndB AND StartB < EndA
                                    if (block['start'] < dropEndHour &&
                                        calculatedHour < endHour) {
                                      collision = true;
                                      break;
                                    }
                                  }
                                }

                                if (collision) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: PrimeCareText(
                                        AppLocalizations.of(
                                          context,
                                        )!.doubleBookingDetectedThePhysicalSchedule,
                                      ),
                                      backgroundColor: PrimeCareColors.rose,
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  _scheduleBlocks.add({
                                    'provider': targetProvider,
                                    'start': calculatedHour,
                                    'duration': droppedItem['duration'],
                                    'client': droppedItem['client'],
                                    'type': droppedItem['type'],
                                    'state': droppedItem['state'],
                                  });
                                  _waitlist.remove(droppedItem);
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: PrimeCareText(
                                      'SUCCESS: ${droppedItem['client']} bound to $targetProvider.',
                                    ),
                                    backgroundColor: PrimeCareColors.emerald,
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(Map<String, dynamic> block, {double opacity = 1.0}) {
    final Color blockColor = _getStateColor(block['state']);
    return PrimeCareCard(
      width: _columnWidth - 16,
      padding: EdgeInsets.all(12),

      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimeCareText(
                block['client'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: blockColor,
                  fontSize: 13,
                ),
              ),
              PrimeCareIcon(
                Icons.drag_indicator_rounded,
                size: 14,
                color: blockColor.withAlpha(100),
              ),
            ],
          ),
          SizedBox(height: 4),
          PrimeCareText(
            block['type'],
            style: TextStyle(color: Color(0xFF475569), fontSize: 11),
          ),
          SizedBox(height: 6),
          PrimeCareText(
            '${block['duration']} HR BLOCK',
            style: TextStyle(
              color: PrimeCareColors.slate400,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
