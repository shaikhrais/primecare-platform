import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PswDailyScheduleScreen extends StatefulWidget {
  const PswDailyScheduleScreen({super.key});

  @override
  State<PswDailyScheduleScreen> createState() => _PswDailyScheduleScreenState();
}

class _PswDailyScheduleScreenState extends State<PswDailyScheduleScreen> {
  bool _maxScheduleOptIn = false;

  final List<Map<String, dynamic>> _dailyItinerary = [
    {
      'time': '08:00 AM - 11:30 AM',
      'client': 'Margaret Atwood',
      'type': 'Complex Care',
      'location': 'Downtown Core - 14B',
      'status': 'upcoming',
      'resources': [
        {'icon': Icons.accessible_forward, 'text': 'Hoyer Lift Verification Required'},
        {'icon': Icons.key, 'text': 'FOB: 4192'},
      ]
    },
    {
      'time': '12:00 PM - 02:00 PM',
      'client': 'Arthur Pendelton',
      'type': 'Medication Protocol',
      'location': 'Midtown - Unit 2',
      'status': 'upcoming',
      'resources': [
        {'icon': Icons.medication, 'text': 'Lockbox Code: 8812'},
        {'icon': Icons.inventory, 'text': 'Wound Care Kit'},
      ]
    },
    {
      'time': '02:30 PM - 05:00 PM',
      'client': 'Sarah Jenkins',
      'type': 'Physical Therapy Support',
      'location': 'Etobicoke',
      'status': 'unassigned',
      'resources': [
        {'icon': Icons.directions_car, 'text': 'Transit Route 42'},
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const PrimeCareIcon(Icons.arrow_back_ios_new, color: PrimeCareColors.radarDark),
          onPressed: () => context.pop(),
        ),
        title: const PrimeCareText('My Daily Timeline', style: TextStyle(color: PrimeCareColors.radarDark, fontWeight: FontWeight.bold)),
      ),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: CustomScrollView(
        slivers: [
          // Max Schedule Toggle Component
          SliverToBoxAdapter(
            child: PrimeCarePadding(
              padding: const EdgeInsets.all(24.0),
              child: PrimeCareCard(
                padding: const EdgeInsets.all(20),
                
                child: PrimeCareColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeCareRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PrimeCareRow(
                          children: [
                            PrimeCareIcon(Icons.auto_graph, color: Colors.white, size: 28),
                            PrimeCareSizedBox(width: 8),
                            PrimeCareText('MAX OPTION', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                          ],
                        ),
                        Switch(
                          value: _maxScheduleOptIn,
                          activeColor: PrimeCareColors.emerald,
                          activeTrackColor: Colors.white,
                          inactiveThumbColor: Colors.white54,
                          inactiveTrackColor: Colors.black26,
                          onChanged: (val) {
                            HapticFeedback.heavyImpact();
                            setState(() => _maxScheduleOptIn = val);
                            if (val) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: PrimeCareText('Max Option Enabled. Dispatch will auto-assign up to 12 hours.'),
                                backgroundColor: PrimeCareColors.emerald,
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                    const PrimeCareSizedBox(height: 8),
                    PrimeCareText(
                      _maxScheduleOptIn 
                        ? 'Algorithm actively routing pending shifts to fill your gaps.'
                        : 'Toggle to automatically receive maximum shift allocations for today.',
                      style: TextStyle(color: Colors.white.withAlpha(220), fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Core Timeline Header
          const SliverToBoxAdapter(
            child: PrimeCarePadding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: PrimeCareText("Today's Itinerary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PrimeCareColors.radarDark)),
            ),
          ),

          // Structural Timeline Rendering
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final shift = _dailyItinerary[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: PrimeCarePadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                        child: _buildTimelineNode(shift, index == _dailyItinerary.length - 1),
                      ),
                    ),
                  ),
                );
              },
              childCount: _dailyItinerary.length,
            ),
          ),
          
          const SliverToBoxAdapter(child: PrimeCareSizedBox(height: 80)),
        ],
      )
        ),
      ),
    );
  }

  Widget _buildTimelineNode(Map<String, dynamic> shift, bool isLast) {
    return IntrinsicHeight(
      child: PrimeCareRow(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Stem Matrix
          PrimeCareSizedBox(
            width: 40,
            child: PrimeCareColumn(
              children: [
                PrimeCareCard(
                  width: 16, height: 16,
                  
                ),
                if (!isLast)
                  PrimeCareExpanded(
                    child: PrimeCareContainer(
                      width: 2,
                      color: PrimeCareColors.slate200,
                    ),
                  )
              ],
            ),
          ),
          
          // Timeline Card Payload
          PrimeCareExpanded(
            child: PrimeCarePadding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: PrimeCareCard(
                padding: const EdgeInsets.all(20),
                
                child: PrimeCareColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeCareText(shift['time'], style: const TextStyle(fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark, fontSize: 16)),
                    const PrimeCareSizedBox(height: 4),
                    PrimeCareText(shift['client'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6366F1), fontSize: 18)),
                    PrimeCareText('${shift['type']} • ${shift['location']}', style: const TextStyle(color: PrimeCareColors.slate500, fontSize: 14)),
                    
                    if ((shift['resources'] as List).isNotEmpty) ...[
                      const PrimeCarePadding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                      ),
                      const PrimeCareText('REQUIRED RESOURCES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: PrimeCareColors.slate400)),
                      const PrimeCareSizedBox(height: 8),
                      ...((shift['resources'] as List).map((res) {
                        return PrimeCarePadding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: PrimeCareRow(
                            children: [
                              PrimeCareIcon(res['icon'], size: 16, color: PrimeCareColors.amber),
                              const PrimeCareSizedBox(width: 8),
                              PrimeCareExpanded(child: PrimeCareText(res['text'], style: const TextStyle(color: Color(0xFF475569), fontSize: 13, fontWeight: FontWeight.w500))),
                            ],
                          ),
                        );
                      })),
                    ]
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
