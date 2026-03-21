import 'package:flutter/material.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A)),
          onPressed: () => context.pop(),
        ),
        title: const Text('My Daily Timeline', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: DesktopPaneWrapper(
          child: CustomScrollView(
        slivers: [
          // Max Schedule Toggle Component
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)]), // Deep Purple AI Gradient
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Color(0x336D28D9), blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.auto_graph, color: Colors.white, size: 28),
                            SizedBox(width: 8),
                            Text('MAX OPTION', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                          ],
                        ),
                        Switch(
                          value: _maxScheduleOptIn,
                          activeColor: const Color(0xFF10B981),
                          activeTrackColor: Colors.white,
                          inactiveThumbColor: Colors.white54,
                          inactiveTrackColor: Colors.black26,
                          onChanged: (val) {
                            HapticFeedback.heavyImpact();
                            setState(() => _maxScheduleOptIn = val);
                            if (val) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Max Option Enabled. Dispatch will auto-assign up to 12 hours.'),
                                backgroundColor: Color(0xFF10B981),
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text("Today's Itinerary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
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
                      child: Padding(
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
          
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      )
        ),
      ),
    );
  }

  Widget _buildTimelineNode(Map<String, dynamic> shift, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Stem Matrix
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 16, height: 16,
                  decoration: BoxDecoration(
                    color: shift['status'] == 'unassigned' ? Colors.amber : const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: const Color(0xFFE2E8F0),
                    ),
                  )
              ],
            ),
          ),
          
          // Timeline Card Payload
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(shift['time'], style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A), fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(shift['client'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6366F1), fontSize: 18)),
                    Text('${shift['type']} • ${shift['location']}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                    
                    if ((shift['resources'] as List).isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                      ),
                      const Text('REQUIRED RESOURCES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Color(0xFF94A3B8))),
                      const SizedBox(height: 8),
                      ...((shift['resources'] as List).map((res) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            children: [
                              Icon(res['icon'], size: 16, color: const Color(0xFFF59E0B)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(res['text'], style: const TextStyle(color: Color(0xFF475569), fontSize: 13, fontWeight: FontWeight.w500))),
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
