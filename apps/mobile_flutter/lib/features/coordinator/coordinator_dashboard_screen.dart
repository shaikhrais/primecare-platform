import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CoordinatorDashboardScreen extends StatefulWidget {
  const CoordinatorDashboardScreen({super.key});

  @override
  State<CoordinatorDashboardScreen> createState() => _CoordinatorDashboardScreenState();
}

class _CoordinatorDashboardScreenState extends State<CoordinatorDashboardScreen> {
  bool _surgeActive = false;

  final bool _isGlobalCodeBlack = true; // Simulating the global macro override

  final List<Map<String, dynamic>> _unfilledShifts = [
    {'id': 'u_1', 'time': '4:00 PM - 8:00 PM', 'client': 'Eliza Thornberry', 'geo': 'Etobicoke', 'matched': 12},
    {'id': 'u_2', 'time': '6:00 PM - 10:00 PM', 'client': 'George Harrison', 'geo': 'North York', 'matched': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: _isGlobalCodeBlack ? PrimeCareColors.radarDark : Color(0xFFF8FAFC),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: CustomScrollView(
            slivers: [
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: _isGlobalCodeBlack ? Colors.black87 : Color(0xFF4338CA), 
            flexibleSpace: FlexibleSpaceBar(
              background: PrimeCareCard(
                
                child: PrimeCareSafeArea(
                  child: PrimeCarePadding(
                    padding: EdgeInsets.all(24.0),
                    child: PrimeCareColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PrimeCareSizedBox(height: 10),
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimeCareText(_isGlobalCodeBlack ? 'MACRO OVERRIDE ACTIVE' : 'DISPATCH LOGISTICS', 
                                style: TextStyle(color: _isGlobalCodeBlack ? Colors.redAccent : Color(0xFFC7D2FE), fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
                            PrimeCareBadge(text: _isGlobalCodeBlack ? 'AUTOPILOT LOCKED' : '2 Unfilled Limits', color: Colors.white)
                          ],
                        ),
                        PrimeCareSizedBox(height: 8),
                        PrimeCareRow(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimeCareText(_isGlobalCodeBlack ? '[CODE BLACK]' : 'Operations Hub', 
                                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                            PrimeCareRow(
                              children: [
                                IconButton(
                                  icon: PrimeCareIcon(Icons.explore_rounded, color: Colors.white, size: 32),
                                  onPressed: () {
                                    HapticFeedback.heavyImpact();
                                    context.push('/coordinator/live-map');
                                  },
                                ),
                                IconButton(
                                  icon: PrimeCareIcon(Icons.calendar_month_rounded, color: Colors.white, size: 32),
                                  onPressed: () {
                                    HapticFeedback.heavyImpact();
                                    context.push('/coordinator/fleet-matrix');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        
                        // Active Surge Multiplier Control Switch
                        PrimeCareCard(
                          padding: EdgeInsets.all(20),
                          backgroundColor: _surgeActive ? PrimeCareColors.emerald : Colors.white12,
                          child: PrimeCareRow(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimeCareColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimeCareRow(
                                    children: [
                                      PrimeCareIcon(_surgeActive ? Icons.bolt_rounded : Icons.offline_bolt_rounded, color: Colors.white, size: 24),
                                      PrimeCareSizedBox(width: 8),
                                      PrimeCareText(_surgeActive ? 'SURGE PRESET ACTIVE' : 'Enable +1.5x Surge', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                                    ],
                                  ),
                                  PrimeCareSizedBox(height: 4),
                                  PrimeCareText(_surgeActive ? 'Broadcasting incentives to 45 PSWs' : 'Standard flat rate dispatched locally', style: TextStyle(color: _surgeActive ? Color(0xFFD1FAE5) : Color(0xFFC7D2FE), fontSize: 13)),
                                ],
                              ),
                              Switch(
                                value: _surgeActive,
                                activeThumbColor: Colors.white,
                                activeTrackColor: Color(0xFF047857),
                                inactiveThumbColor: PrimeCareColors.slate400,
                                inactiveTrackColor: PrimeCareColors.radarDark,
                                onChanged: (val) {
                                  HapticFeedback.heavyImpact();
                                  setState(() => _surgeActive = val);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          SliverPadding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final shift = _unfilledShifts[index];
                  return PrimeCarePadding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: PrimeCareCard(
                      padding: EdgeInsets.all(24),
                      child: PrimeCareColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimeCareRow(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimeCareText(shift['time'], style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
                              PrimeCareBadge(text: '${shift['matched']} Matches', color: Color(0xFF6366F1))
                            ],
                          ),
                          PrimeCareSizedBox(height: 12),
                          PrimeCareText(shift['client'], style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w600)),
                          PrimeCareSizedBox(height: 4),
                          PrimeCareRow(
                            children: [
                              PrimeCareIcon(Icons.location_on, color: PrimeCareColors.slate400, size: 16),
                              PrimeCareSizedBox(width: 4),
                              PrimeCareText(shift['geo'], style: TextStyle(color: PrimeCareColors.slate500, fontSize: 14)),
                            ],
                          ),
                          PrimeCareSizedBox(height: 24),
                          PrimeCareSizedBox(
                            width: double.infinity,
                            child: PrimeCareButton(
                              onPressed: () => HapticFeedback.mediumImpact(),
                              text: 'BROADCAST SHIFT TO PSWs',
                              isPrimary: true,
                              icon: Icons.send_rounded,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: _unfilledShifts.length,
              ),
            ),
          )
        ],
      ),
      ),
      ),
    );
  }
}
