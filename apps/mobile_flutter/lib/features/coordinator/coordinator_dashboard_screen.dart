import 'package:flutter/material.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CoordinatorDashboardScreen extends StatefulWidget {
  const CoordinatorDashboardScreen({super.key});

  @override
  State<CoordinatorDashboardScreen> createState() => _CoordinatorDashboardScreenState();
}

class _CoordinatorDashboardScreenState extends State<CoordinatorDashboardScreen> {
  bool _surgeActive = false;

  final List<Map<String, dynamic>> _unfilledShifts = [
    {'id': 'u_1', 'time': '4:00 PM - 8:00 PM', 'client': 'Eliza Thornberry', 'geo': 'Etobicoke', 'matched': 12},
    {'id': 'u_2', 'time': '6:00 PM - 10:00 PM', 'client': 'George Harrison', 'geo': 'North York', 'matched': 4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: DesktopPaneWrapper(
          child: CustomScrollView(
            slivers: [
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF4338CA), // Intensely Deep Indigo
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF312E81), Color(0xFF4F46E5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('DISPATCH LOGISTICS', style: TextStyle(color: Color(0xFFC7D2FE), fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
                            const PrimeCareBadge(text: '2 Unfilled Limits', color: Colors.white)
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Operations Hub', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.explore_rounded, color: Colors.white, size: 32),
                                  onPressed: () {
                                    HapticFeedback.heavyImpact();
                                    context.push('/coordinator/live-map');
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 32),
                                  onPressed: () {
                                    HapticFeedback.heavyImpact();
                                    context.push('/coordinator/fleet-matrix');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        
                        // Active Surge Multiplier Control Switch
                        PrimeCareCard(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: _surgeActive ? const Color(0xFF10B981) : Colors.white12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(_surgeActive ? Icons.bolt_rounded : Icons.offline_bolt_rounded, color: Colors.white, size: 24),
                                      const SizedBox(width: 8),
                                      Text(_surgeActive ? 'SURGE PRESET ACTIVE' : 'Enable +1.5x Surge', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(_surgeActive ? 'Broadcasting incentives to 45 PSWs' : 'Standard flat rate dispatched locally', style: TextStyle(color: _surgeActive ? const Color(0xFFD1FAE5) : const Color(0xFFC7D2FE), fontSize: 13)),
                                ],
                              ),
                              Switch(
                                value: _surgeActive,
                                activeColor: Colors.white,
                                activeTrackColor: const Color(0xFF047857),
                                inactiveThumbColor: const Color(0xFF94A3B8),
                                inactiveTrackColor: const Color(0xFF0F172A),
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
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final shift = _unfilledShifts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PrimeCareCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(shift['time'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF0F172A))),
                              PrimeCareBadge(text: '${shift['matched']} Matches', color: const Color(0xFF6366F1))
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(shift['client'], style: const TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Color(0xFF94A3B8), size: 16),
                              const SizedBox(width: 4),
                              Text(shift['geo'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
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
