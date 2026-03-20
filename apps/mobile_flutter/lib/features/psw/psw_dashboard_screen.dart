import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../shared/widgets/offline_banner.dart';

class PswDashboardScreen extends StatelessWidget {
  const PswDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == ConnectivityResult.none) {
                return const OfflineBanner();
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: CustomScrollView(
                  slivers: [
          // Sticky Massive Geometric Header
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            backgroundColor: const Color(0xFFF8FAFC),
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: Text(
                'My Shifts',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 30),
                onPressed: () {},
                color: const Color(0xFF0F172A),
              ),
              const SizedBox(width: 12),
            ],
          ),

          // Glassmorphic Surge Alert Component
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0x1510B981), // Glassmorphic Emerald Overlay
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x3310B981)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bolt, color: Color(0xFF10B981), size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('High Demand Alert', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          const Text(
                            'Surge pricing active for evening shifts (+1.5x payout rate).',
                            style: TextStyle(color: Color(0xFF475569), fontSize: 14),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Pinned Sticky Date Filter
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyDateDelegate(
              child: Container(
                color: const Color(0xFFF8FAFC),
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Row(
                  children: [
                    const Text('Today', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('3 Shifts', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Swipe-to-Action Shift Cards
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: SlideAnimation(
                    verticalOffset: 60.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Dismissible(
                          key: Key('shift_$index'),
                    background: Container(
                      decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 24),
                      child: const Icon(Icons.check, color: Colors.white, size: 36),
                    ),
                    secondaryBackground: Container(
                      decoration: BoxDecoration(color: const Color(0xFFF59E0B), borderRadius: BorderRadius.circular(20)),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      child: const Icon(Icons.handshake, color: Colors.white, size: 36),
                    ),
                    onDismissed: (direction) {
                       // Trigger Snackbar with Undo Native Architecture
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: const Text('Shift acknowledged successfully.'),
                           backgroundColor: const Color(0xFF0F172A),
                           duration: const Duration(seconds: 4),
                           behavior: SnackBarBehavior.floating,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                           action: SnackBarAction(label: 'UNDO', textColor: const Color(0xFF10B981), onPressed: (){}),
                         )
                       );
                    },
                    child: InkWell(
                      onTap: () => context.push('/psw/live-visit/uuid-shift-$index'),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          // Soft Neumorphic Diffused Shadow
                          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('10:00 AM - 2:00 PM', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A), fontSize: 18)),
                                Icon(Icons.chevron_right, color: const Color(0xFFCBD5E1), size: 28),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xFFDBEAFE),
                                  child: Icon(Icons.person, color: Color(0xFF3B82F6), size: 18),
                                ),
                                const SizedBox(width: 12),
                                const Text('Sarah Jenkins', style: TextStyle(color: Color(0xFF475569), fontSize: 16, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text('123 Main St, Unit 4B, Toronto ON', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        childCount: 3,
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 80)), // Padding for bottom nav
        ],
      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyDateDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyDateDelegate({required this.child});

  @override
  double get minExtent => 48.0;
  @override
  double get maxExtent => 48.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyDateDelegate oldDelegate) {
    return false;
  }
}
