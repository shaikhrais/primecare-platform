import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../shared/widgets/offline_banner.dart';
import '../../../core/localization/app_strings.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswDashboardScreen extends StatefulWidget {
  const PswDashboardScreen({super.key});

  @override
  State<PswDashboardScreen> createState() => _PswDashboardScreenState();
}

class _PswDashboardScreenState extends State<PswDashboardScreen> {
  // Simulating the Cloudflare Edge global state WebSocket override
  final bool _isGlobalCodeBlack = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      // Scaffold automatically inherits scaffoldBackgroundColor from theme.dart
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
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 140,
                  // AppBar inherits automatically from theme.dart
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    title: Text(
                      AppStrings.myShiftsTitle,
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined, size: 30),
                      onPressed: () {},
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                  ],
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: PrimeCareCard(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: _isGlobalCodeBlack ? Colors.red[900]!.withOpacity(0.2) : colorScheme.secondary.withAlpha(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(_isGlobalCodeBlack ? Icons.warning_amber_rounded : Icons.bolt, 
                                color: _isGlobalCodeBlack ? Colors.redAccent : colorScheme.secondary, size: 28),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_isGlobalCodeBlack ? 'SYSTEM OVERRIDE: CODE BLACK' : AppStrings.highDemandAlertTitle, 
                                    style: theme.textTheme.titleLarge?.copyWith(
                                        color: _isGlobalCodeBlack ? Colors.redAccent : null,
                                        fontWeight: _isGlobalCodeBlack ? FontWeight.w900 : null
                                    )),
                                const SizedBox(height: 4),
                                Text(
                                  _isGlobalCodeBlack ? 'Ecosystem in critical state. All shifts mathematically boosted to +1.5x Hazard Pay globally. Do not travel if unsafe.' : AppStrings.highDemandAlertDesc,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color: _isGlobalCodeBlack ? Colors.red[200] : null
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyDateDelegate(
                    child: Container(
                      color: theme.scaffoldBackgroundColor,
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                      child: Row(
                        children: [
                          Text(AppStrings.today, style: theme.textTheme.titleLarge),
                          const SizedBox(width: 8),
                          PrimeCareBadge(
                            text: AppStrings.shiftCountLabel,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverLayoutBuilder(
                    builder: (BuildContext context, SliverConstraints constraints) {
                      if (constraints.crossAxisExtent > 800) {
                        return SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (constraints.crossAxisExtent / 400).floor(),
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 16.0,
                            childAspectRatio: 2.2,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _buildShiftCard(context, index),
                            childCount: 3,
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: _buildShiftCard(context, index),
                          ),
                          childCount: 3,
                        ),
                      );
                    },
                  ),
                ),
                
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 60.0,
        child: FadeInAnimation(
          child: Dismissible(
            key: Key('shift_$index'),
            background: Container(
              decoration: BoxDecoration(color: colorScheme.secondary, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 24),
              child: const Icon(Icons.check, color: Colors.white, size: 36),
            ),
            secondaryBackground: Container(
              decoration: BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 24),
              child: const Icon(Icons.handshake, color: Colors.white, size: 36),
            ),
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(AppStrings.shiftAckSuccess),
                  backgroundColor: colorScheme.primary,
                  duration: const Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  action: SnackBarAction(label: AppStrings.undo, textColor: colorScheme.secondary, onPressed: (){}),
                )
              );
            },
            child: InkWell(
              onTap: () => context.push('/psw/live-visit/uuid-shift-$index'),
              borderRadius: BorderRadius.circular(20),
              child: PrimeCareCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('10:00 AM - 2:00 PM', style: theme.textTheme.titleLarge?.copyWith(fontSize: 18)),
                        Icon(Icons.chevron_right, color: theme.dividerColor, size: 28),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const PrimeCareAvatar(radius: 16),
                        const SizedBox(width: 12),
                        Text('Sarah Jenkins', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('123 Main St, Unit 4B, Toronto ON', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
        ),
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
    return child != oldDelegate.child;
  }
}
