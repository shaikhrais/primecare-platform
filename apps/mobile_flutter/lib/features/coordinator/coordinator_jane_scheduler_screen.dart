import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoordinatorJaneSchedulerScreen extends StatefulWidget {
  const CoordinatorJaneSchedulerScreen({super.key});

  @override
  State<CoordinatorJaneSchedulerScreen> createState() => _CoordinatorJaneSchedulerScreenState();
}

class _CoordinatorJaneSchedulerScreenState extends State<CoordinatorJaneSchedulerScreen> {
  final double _hourHeight = 100.0;
  final double _columnWidth = 220.0;
  final double _timeColumnWidth = 60.0;
  final int _startHour = 7; // 07:00 AM
  final int _endHour = 20;  // 08:00 PM

  // The Top Axis list of resources / workers
  final List<Map<String, dynamic>> _providers = [
    {'id': 'RN-1', 'name': 'Eliza Thornberry', 'role': 'RN'},
    {'id': 'PSW-1', 'name': 'Sarah Jenkins', 'role': 'PSW'},
    {'id': 'PSW-2', 'name': 'Marcus Vance', 'role': 'PSW'},
    {'id': 'PSW-3', 'name': 'Julia Roberts', 'role': 'PSW'},
  ];

  // Mathematical Schedule Blocks
  final List<Map<String, dynamic>> _scheduleBlocks = [
    {'provider': 'RN-1', 'start': 8.0, 'duration': 1.5, 'client': 'A. Pendelton', 'type': 'Wound Care', 'state': 'arrived'},
    {'provider': 'RN-1', 'start': 10.0, 'duration': 2.0, 'client': 'M. Atwood', 'type': 'Assessment', 'state': 'scheduled'},
    {'provider': 'PSW-1', 'start': 7.5, 'duration': 3.0, 'client': 'J. Smith', 'type': 'Complex Care', 'state': 'completed'},
    {'provider': 'PSW-2', 'start': 9.0, 'duration': 4.0, 'client': 'G. Harrison', 'type': 'Companionship', 'state': 'en_route'},
    {'provider': 'PSW-2', 'start': 14.0, 'duration': 2.5, 'client': 'S. Croft', 'type': 'Physical Support', 'state': 'scheduled'},
    {'provider': 'PSW-3', 'start': 8.0, 'duration': 8.0, 'client': 'Auto-Max Sequence', 'type': 'Utilization', 'state': 'auto'},
  ];

  // Waitlisted shifts
  final List<Map<String, dynamic>> _waitlist = [
    {'client': 'H. Potter', 'type': 'Standard Intake', 'duration': 1.0, 'state': 'scheduled'},
    {'client': 'R. Weasley', 'type': 'Physical Check', 'duration': 2.0, 'state': 'scheduled'},
  ];

  Color _getStateColor(String state) {
    switch (state) {
      case 'completed': return const Color(0xFF64748B); // Slate Grey
      case 'arrived': return const Color(0xFF10B981); // Emerald Green
      case 'en_route': return const Color(0xFFF59E0B); // Amber Warning
      case 'scheduled': return const Color(0xFF3B82F6); // Standard Blue
      case 'auto': return const Color(0xFF8B5CF6); // AI Purple
      case 'no_show': return const Color(0xFFE11D48); // Red
      default: return const Color(0xFFE2E8F0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Jane Matrix Scheduler', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A)), onPressed: () => context.pop()),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: const Color(0xFF8B5CF6), borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text('MAX OPTION UTILIZATION', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
          )
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==== GHOST SIDECAR (WAITLIST) ====
          Container(
            width: 200,
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Waitlist Array', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF64748B), letterSpacing: 1.5)),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _waitlist.length,
                    itemBuilder: (context, index) {
                      final item = _waitlist[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Draggable<Map<String, dynamic>>(
                          data: item,
                          feedback: Material(
                            color: Colors.transparent,
                            child: _buildShiftCard(item, opacity: 0.8),
                          ),
                          childWhenDragging: Opacity(opacity: 0.3, child: _buildShiftCard(item)),
                          child: _buildShiftCard(item),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          
          // Y-Axis Time Static Column
          SizedBox(
            width: _timeColumnWidth,
            child: Column(
              children: [
                Container(height: 50, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)), right: BorderSide(color: Color(0xFFE2E8F0))))), // Corner Block
                Expanded(
                  child: ListView.builder(
                    itemCount: _endHour - _startHour + 1,
                    physics: const ClampingScrollPhysics(), // Match scroll later if synced, but usually interactive viewer handles inner body
                    itemBuilder: (context, index) {
                      final time = _startHour + index;
                      final String amPm = time >= 12 ? 'PM' : 'AM';
                      final int displayTime = time > 12 ? time - 12 : time;
                      return Container(
                        height: _hourHeight,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9)), right: BorderSide(color: Color(0xFFE2E8F0))),
                        ),
                        child: Center(child: Text('$displayTime:00 $amPm', style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 12))),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // The 2D Scrolling Matrix payload
          Expanded(
            child: InteractiveViewer(
              constrained: false, // Allows X and Y infinite panning mathematically
              boundaryMargin: const EdgeInsets.all(0),
              minScale: 0.5,
              maxScale: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // X-Axis Provider Static Headers
                  Row(
                    children: _providers.map((p) => Container(
                      width: _columnWidth,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)), right: BorderSide(color: Color(0xFFF1F5F9))),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A), fontSize: 14)),
                            Text('${p['role']} • Active', style: const TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  // The Timeline Physical Grid
                  SizedBox(
                    height: (_endHour - _startHour + 1) * _hourHeight,
                    width: _providers.length * _columnWidth,
                    child: Stack(
                      children: [
                        // Background Grid Lines Layout
                        ...List.generate(_endHour - _startHour + 1, (y) {
                          return Positioned(
                            top: y * _hourHeight, left: 0, right: 0,
                            child: Container(height: 1, color: const Color(0xFFF1F5F9)),
                          );
                        }),
                        ...List.generate(_providers.length, (x) {
                          return Positioned(
                            top: 0, bottom: 0, left: x * _columnWidth,
                            child: Container(width: 1, color: const Color(0xFFF1F5F9)),
                          );
                        }),
                        
                        // Shift Block Overlays
                        ..._scheduleBlocks.map((block) {
                          final providerIndex = _providers.indexWhere((p) => p['id'] == block['provider']);
                          if (providerIndex == -1) return const SizedBox.shrink();
                          
                          final double topOffset = (block['start'] - _startHour) * _hourHeight;
                          final double blockHeight = block['duration'] * _hourHeight;
                          final Color blockColor = _getStateColor(block['state']);
                          
                          return Positioned(
                            left: providerIndex * _columnWidth + 4, // 4px padding
                            width: _columnWidth - 8,
                            top: topOffset,
                            height: blockHeight,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: blockColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                                border: Border(left: BorderSide(color: blockColor, width: 4)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(block['client'], style: TextStyle(fontWeight: FontWeight.bold, color: blockColor.withAlpha(200), fontSize: 14)),
                                      Icon(Icons.check_circle, size: 14, color: blockColor),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(block['type'], style: const TextStyle(color: Color(0xFF475569), fontSize: 12)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        // Waitlist Dropping DragTarget Layout Matrix
                        ...List.generate(_providers.length, (x) {
                          return Positioned(
                            left: x * _columnWidth,
                            top: 0, 
                            bottom: 0,
                            width: _columnWidth,
                            child: DragTarget<Map<String, dynamic>>(
                              builder: (context, candidateData, rejectedData) {
                                return Container(color: candidateData.isNotEmpty ? const Color(0x1110B981) : Colors.transparent);
                              },
                              onAcceptWithDetails: (details) {
                                // Mathematical algorithm extracting Y Drop Constraints relative to Time Interval
                                final droppedItem = details.data;
                                
                                // Calculate the dropped hour roughly based on Local Offset
                                // Assuming drop offset directly to InteractiveViewer Stack (Scale=1.0)
                                // Standard offset maps directly because DragTarget is sized identically.
                                final double localY = details.offset.dy - 100; // Account for AppBar + Heuristic offsets
                                double calculatedHour = (localY / _hourHeight).floorToDouble() + _startHour;
                                if (calculatedHour < _startHour) calculatedHour = _startHour.toDouble();
                                
                                // Aggressive Double Booking Hardware Trap
                                final String targetProvider = _providers[x]['id'];
                                bool collision = false;
                                for (var block in _scheduleBlocks) {
                                  if (block['provider'] == targetProvider) {
                                    final endHour = block['start'] + block['duration'];
                                    final dropEndHour = calculatedHour + droppedItem['duration'];
                                    // Overlap logic: StartA < EndB AND StartB < EndA
                                    if (block['start'] < dropEndHour && calculatedHour < endHour) {
                                      collision = true;
                                      break;
                                    }
                                  }
                                }

                                if (collision) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('DOUBLE-BOOKING DETECTED. The physical schedule matrix rejected the collision constraint.'),
                                    backgroundColor: Color(0xFFE11D48)
                                  ));
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
                                
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('SUCCESS: ${droppedItem['client']} bound to ${targetProvider}.'),
                                  backgroundColor: const Color(0xFF10B981)
                                ));
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShiftCard(Map<String, dynamic> block, {double opacity = 1.0}) {
    final Color blockColor = _getStateColor(block['state']);
    return Container(
      width: _columnWidth - 16,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: blockColor.withAlpha((25 * opacity).toInt()),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: blockColor.withOpacity(opacity), width: 4)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(block['client'], style: TextStyle(fontWeight: FontWeight.bold, color: blockColor, fontSize: 13)),
              Icon(Icons.drag_indicator_rounded, size: 14, color: blockColor.withAlpha(100)),
            ],
          ),
          const SizedBox(height: 4),
          Text(block['type'], style: const TextStyle(color: Color(0xFF475569), fontSize: 11)),
          const SizedBox(height: 6),
          Text('${block['duration']} HR BLOCK', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
        ],
      ),
    );
  }
}
