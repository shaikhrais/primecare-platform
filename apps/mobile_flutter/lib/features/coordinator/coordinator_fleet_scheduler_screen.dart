import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/services.dart';
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
    
    Future.delayed(Duration(seconds: 2), () {
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
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: PrimeCareText(AppLocalizations.of(context)!.autoMaxRoutingComplete28Pending),
        backgroundColor: Color(0xFF6366F1),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareColumn(
        children: [
          // Dispatch Control Hub
          PrimeCareCard(
            padding: EdgeInsets.all(24),
            
            child: PrimeCareRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimeCareColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeCareText('Global AI Dispatch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: PrimeCareColors.slate500, letterSpacing: 1)),
                    SizedBox(height: 4),
                    PrimeCareText('28 Unassigned Hours Pending', style: TextStyle(color: PrimeCareColors.rose, fontWeight: FontWeight.w900, fontSize: 18)),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _isAutoFilling ? null : _triggerMaxScheduleAutoFill,
                  icon: _isAutoFilling 
                      ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : PrimeCareIcon(Icons.auto_awesome),
                  label: PrimeCareText(AppLocalizations.of(context)!.autoMaxFill),
                  
                )
              ],
            ),
          ),
          
          // Timeline Rendering Array
          PrimeCareExpanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: AnimationLimiter(
                child: PrimeCareColumn(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: Duration(milliseconds: 500),
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
    return PrimeCareCard(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Identity Header
          PrimeCareRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrimeCareRow(
                children: [
                  CircleAvatar(radius: 16, backgroundColor: Color(0xFFDBEAFE), child: PrimeCareText(worker['id'].toString().substring(0,2), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  SizedBox(width: 12),
                  PrimeCareText(worker['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
                ],
              ),
              PrimeCareRow(
                children: [
                  if (worker['max_opt_in'])
                    PrimeCareCard(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      
                      child: PrimeCareText('MAX OPTION', style: TextStyle(color: PrimeCareColors.emerald, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  PrimeCareText(worker['capacity'], style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              )
            ],
          ),
          SizedBox(height: 16),
          
          // Gantt Timeline (08:00 -> 20:00) 12-hour span
          PrimeCareCard(
            height: 48,
            
            child: PrimeCareStack(
              children: (worker['blocks'] as List).map<Widget>((block) {
                // Parsing time to relative X percentage natively
                final int hour = int.parse(block['time'].split(':')[0]);
                final double startFactor = (hour - 8) / 12.0; 
                final double widthFactor = block['span'] / 12.0;
                
                final Color blockColor = block['type'] == 'auto_assigned' 
                    ? PrimeCareColors.purple // Deep AI Purple
                    : Color(0xFF3B82F6); // Standard Blue
                
                return Positioned(
                  left: MediaQuery.of(context).size.width * 0.8 * startFactor,
                  width: MediaQuery.of(context).size.width * 0.8 * widthFactor,
                  top: 0, bottom: 0,
                  child: PrimeCareCard(
                    margin: EdgeInsets.all(4),
                    
                    child: PrimeCareCenter(
                      child: PrimeCareText('${block['span']} HR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
