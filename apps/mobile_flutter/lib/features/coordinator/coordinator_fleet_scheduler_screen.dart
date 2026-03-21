import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../shared/layouts/desktop_pane_wrapper.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CoordinatorFleetSchedulerScreen extends StatefulWidget {
  const CoordinatorFleetSchedulerScreen({super.key});

  @override
  State<CoordinatorFleetSchedulerScreen> createState() => _CoordinatorFleetSchedulerScreenState();
}

class _CoordinatorFleetSchedulerScreenState extends State<CoordinatorFleetSchedulerScreen> {
  bool _isAutoFilling = false;
  
  // Simulated Gantt Payload Matrix
  final List<Map<String, dynamic>> _fleetMatrix = [
    {
      'id': 'PSW-01', 'name': 'Sarah Jenkins', 'max_opt_in': true, 'capacity': '4/12 HRS',
      'blocks': [ {'time': '08:00', 'span': 2, 'type': 'meds'}, {'time': '12:00', 'span': 2, 'type': 'complex'} ]
    },
    {
      'id': 'PSW-02', 'name': 'Marcus Vance', 'max_opt_in': false, 'capacity': '6/8 HRS',
      'blocks': [ {'time': '09:00', 'span': 3, 'type': 'standard'}, {'time': '14:00', 'span': 3, 'type': 'standard'} ]
    },
    {
      'id': 'RN-01', 'name': 'Eliza Thornberry', 'max_opt_in': true, 'capacity': '0/12 HRS',
      'blocks': []
    },
  ];

  void _triggerMaxScheduleAutoFill() {
    HapticFeedback.heavyImpact();
    setState(() => _isAutoFilling = true);
    
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isAutoFilling = false;
        // Physically injecting algorithm outputs into the Matrix
        _fleetMatrix[0]['capacity'] = '12/12 HRS';
        _fleetMatrix[0]['blocks'].addAll([
          {'time': '14:00', 'span': 4, 'type': 'auto_assigned'},
          {'time': '18:00', 'span': 4, 'type': 'auto_assigned'}
        ]);
        
        _fleetMatrix[2]['capacity'] = '12/12 HRS';
        _fleetMatrix[2]['blocks'].addAll([
          {'time': '08:00', 'span': 6, 'type': 'auto_assigned'},
          {'time': '14:00', 'span': 6, 'type': 'auto_assigned'}
        ]);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Auto-Max Routing Complete. 28 pending hours assigned continuously.'),
        backgroundColor: Color(0xFF6366F1),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Fleet Master Scheduler', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: PrimeCareColors.radarDark), onPressed: () => context.pop()),
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: Column(
        children: [
          // Dispatch Control Hub
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: PrimeCareColors.slate200)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Global AI Dispatch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: PrimeCareColors.slate500, letterSpacing: 1)),
                    const SizedBox(height: 4),
                    const Text('28 Unassigned Hours Pending', style: TextStyle(color: PrimeCareColors.rose, fontWeight: FontWeight.w900, fontSize: 18)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _isAutoFilling ? null : _triggerMaxScheduleAutoFill,
                  icon: _isAutoFilling 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.auto_awesome),
                  label: const Text('AUTO-MAX FILL'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                )
              ],
            ),
          ),
          
          // Timeline Rendering Array
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(verticalOffset: 50, child: FadeInAnimation(child: widget)),
                    children: _fleetMatrix.map((worker) => _buildGanttRow(worker)).toList(),
                  ),
                ),
              ),
            ),
          )
        ],
      )
        ),
      ),
    );
  }

  Widget _buildGanttRow(Map<String, dynamic> worker) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PrimeCareColors.slate200),
        boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Identity Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: const Color(0xFFDBEAFE), child: Text(worker['id'].toString().substring(0,2), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 12),
                  Text(worker['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
                ],
              ),
              Row(
                children: [
                  if (worker['max_opt_in'])
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: PrimeCareColors.emerald.withAlpha(30), borderRadius: BorderRadius.circular(8)),
                      child: const Text('MAX OPTION', style: TextStyle(color: PrimeCareColors.emerald, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  Text(worker['capacity'], style: const TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          
          // Gantt Timeline (08:00 -> 20:00) 12-hour span
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: (worker['blocks'] as List).map<Widget>((block) {
                // Parsing time to relative X percentage natively
                final int hour = int.parse(block['time'].split(':')[0]);
                final double startFactor = (hour - 8) / 12.0; 
                final double widthFactor = block['span'] / 12.0;
                
                final Color blockColor = block['type'] == 'auto_assigned' 
                    ? PrimeCareColors.purple // Deep AI Purple
                    : const Color(0xFF3B82F6); // Standard Blue
                
                return Positioned(
                  left: MediaQuery.of(context).size.width * 0.8 * startFactor,
                  width: MediaQuery.of(context).size.width * 0.8 * widthFactor,
                  top: 0, bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: blockColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [BoxShadow(color: blockColor.withAlpha(100), blurRadius: 4, offset: const Offset(0, 2))],
                    ),
                    child: Center(
                      child: Text('${block['span']} HR', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      )
    );
  }
}
