import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswShiftsScreen extends StatefulWidget {
  const PswShiftsScreen({super.key});

  @override
  State<PswShiftsScreen> createState() => _PswShiftsScreenState();
}

class _PswShiftsScreenState extends State<PswShiftsScreen> {
  // Simulating the Cloudflare Edge global state WebSocket override
  final bool _isGlobalCodeBlack = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PrimeCareScaffold(
      // Scaffold automatically inherits scaffoldBackgroundColor from theme.dart
      body: PrimeCareColumn(
        children: [
          StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.data == ConnectivityResult.none) {
                return OfflineBanner();
              }
              return SizedBox.shrink();
            },
          ),
          PrimeCareExpanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 140,
                  // AppBar inherits automatically from theme.dart
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    title: PrimeCareText(
                      AppLocalizations.of(context)!.myShiftsTitle,
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: PrimeCareIcon(
                        Icons.notifications_outlined,
                        size: 30,
                      ),
                      onPressed: () {},
                      color: colorScheme.primary,
                    ),
                    SizedBox(width: 12),
                  ],
                ),

                SliverToBoxAdapter(
                  child: PrimeCarePadding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: PrimeCareCard(
                      padding: EdgeInsets.all(20),
                      backgroundColor: _isGlobalCodeBlack
                          ? Colors.red[900]!.withOpacity(0.2)
                          : colorScheme.secondary.withAlpha(20),
                      child: PrimeCareRow(
                        children: [
                          PrimeCareCard(
                            padding: EdgeInsets.all(12),

                            child: PrimeCareIcon(
                              _isGlobalCodeBlack
                                  ? Icons.warning_amber_rounded
                                  : Icons.bolt,
                              color: _isGlobalCodeBlack
                                  ? Colors.redAccent
                                  : colorScheme.secondary,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 16),
                          PrimeCareExpanded(
                            child: PrimeCareColumn(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimeCareText(
                                  _isGlobalCodeBlack
                                      ? 'SYSTEM OVERRIDE: CODE BLACK'
                                      : AppLocalizations.of(
                                          context,
                                        )!.highDemandAlertTitle,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: _isGlobalCodeBlack
                                        ? Colors.redAccent
                                        : null,
                                    fontWeight: _isGlobalCodeBlack
                                        ? FontWeight.w900
                                        : null,
                                  ),
                                ),
                                SizedBox(height: 4),
                                PrimeCareText(
                                  _isGlobalCodeBlack
                                      ? 'Ecosystem in critical state. All shifts mathematically boosted to +1.5x Hazard Pay globally. Do not travel if unsafe.'
                                      : AppLocalizations.of(
                                          context,
                                        )!.highDemandAlertDesc,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: _isGlobalCodeBlack
                                        ? Colors.red[200]
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyDateDelegate(
                    child: PrimeCareContainer(
                      color: theme.scaffoldBackgroundColor,
                      padding: EdgeInsets.fromLTRB(24, 8, 24, 16),
                      child: PrimeCareRow(
                        children: [
                          PrimeCareText(
                            AppLocalizations.of(context)!.today,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(width: 8),
                          PrimeCareBadge(
                            text: AppLocalizations.of(context)!.shiftCountLabel,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverLayoutBuilder(
                    builder:
                        (BuildContext context, SliverConstraints constraints) {
                          if (constraints.crossAxisExtent > 800) {
                            return SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        (constraints.crossAxisExtent / 400)
                                            .floor(),
                                    mainAxisSpacing: 16.0,
                                    crossAxisSpacing: 16.0,
                                    childAspectRatio: 2.2,
                                  ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                    _buildShiftCard(context, index),
                                childCount: 3,
                              ),
                            );
                          }
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => PrimeCarePadding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: _buildShiftCard(context, index),
                              ),
                              childCount: 3,
                            ),
                          );
                        },
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 80)),
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
      duration: Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 60.0,
        child: FadeInAnimation(
          child: Dismissible(
            key: Key('shift_$index'),
            background: PrimeCareCard(
              padding: EdgeInsets.only(left: 24),
              child: PrimeCareIcon(Icons.check, color: Colors.white, size: 36),
            ),
            secondaryBackground: PrimeCareCard(
              padding: EdgeInsets.only(right: 24),
              child: PrimeCareIcon(
                Icons.handshake,
                color: Colors.white,
                size: 36,
              ),
            ),
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: PrimeCareText(
                    AppLocalizations.of(context)!.shiftAckSuccess,
                  ),
                  backgroundColor: colorScheme.primary,
                  duration: Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  action: SnackBarAction(
                    label: AppLocalizations.of(context)!.undo,
                    textColor: colorScheme.secondary,
                    onPressed: () {},
                  ),
                ),
              );
            },
            child: InkWell(
              onTap: () => context.push('/psw/live-visit/uuid-shift-$index'),
              borderRadius: BorderRadius.circular(20),
              child: PrimeCareCard(
                padding: EdgeInsets.all(24),
                child: PrimeCareColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimeCareRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimeCareText(
                          '10:00 AM - 2:00 PM',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        PrimeCareIcon(
                          Icons.chevron_right,
                          color: theme.dividerColor,
                          size: 28,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    PrimeCareRow(
                      children: [
                        CircleAvatar(radius: 16),
                        SizedBox(width: 12),
                        PrimeCareText(
                          'Sarah Jenkins',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    PrimeCareText(
                      '123 Main St, Unit 4B, Toronto ON',
                      style: theme.textTheme.bodyMedium,
                    ),
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyDateDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
