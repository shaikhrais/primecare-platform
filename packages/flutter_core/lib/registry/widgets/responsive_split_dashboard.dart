// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import '../../config/screen_breakpoints.dart';
import 'responsive_grid.dart';

/// A premium, high-density dashboard split layout designed for large displays.
/// On desktop and wide viewports (width >= 1024px), it divides screen space into:
/// - **Left Column (65%)**: Primary metrics grid and main dashboard widgets (charts, maps, data grids).
/// - **Right Column (35%)**: Secondary panels (Quick Actions, Activity Feed, AI Insights).
/// On smaller displays (handheld/tablet), it gracefully wraps them into a single-column scrolling flow.
class ResponsiveSplitDashboard extends StatelessWidget {
  /// The list of metric/stat card widgets to show at the top of the dashboard.
  final List<Widget> metrics;

  /// The primary widget representing the main dashboard body (e.g. data table, maps).
  final Widget mainContent;

  /// Optional custom sidebar widget. If null, a default sidebar using
  /// [defaultSidebarWidgets] or standard system activities will be constructed.
  final Widget? sidebarContent;

  /// List of custom widgets to arrange in the sidebar column.
  final List<Widget>? defaultSidebarWidgets;

  /// Margin and padding spacing between components.
  final double spacing;

  const ResponsiveSplitDashboard({
    super.key,
    required this.metrics,
    required this.mainContent,
    this.sidebarContent,
    this.defaultSidebarWidgets,
    this.spacing = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final tier = ScreenBreakpoints.getTier(screenWidth);

    // Side-by-side split is active on 2K, 3K, 4K, and 1K (Full HD) screens.
    // Handy handheld / tablet displays wrap to vertical stacks.
    final bool isWideScreen = tier != ResolutionTier.mob && tier != ResolutionTier.tab;

    // Resolve sidebar child
    Widget? sidebarChild;
    if (sidebarContent != null) {
      sidebarChild = sidebarContent;
    } else if (defaultSidebarWidgets != null && defaultSidebarWidgets!.isNotEmpty) {
      sidebarChild = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: defaultSidebarWidgets!
            .expand((widget) => [widget, SizedBox(height: spacing)])
            .toList()
          ..removeLast(), // Remove trailing spacer
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Metrics section (dynamic wrapping prevents excessive wide stretching)
          if (metrics.isNotEmpty) ...[
            ResponsiveGrid(
              spacing: spacing,
              runSpacing: spacing,
              minItemWidth: 260.0,
              maxItemWidth: 400.0,
              children: metrics,
            ),
            SizedBox(height: spacing),
          ],

          // 2. Main content split viewport
          if (isWideScreen && sidebarChild != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 13,
                  child: mainContent,
                ),
                SizedBox(width: spacing),
                Expanded(
                  flex: 7,
                  child: sidebarChild,
                ),
              ],
            )
          else ...[
            mainContent,
            if (sidebarChild != null) ...[
              SizedBox(height: spacing),
              sidebarChild,
            ],
          ],
        ],
      ),
    );
  }
}

/// A highly polished item for the Quick Actions panel grid.
class QuickActionItem {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const QuickActionItem({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

/// A premium, beautiful panel of quick actions, arranged as a grid.
class QuickActionsPanel extends StatelessWidget {
  final List<QuickActionItem> actions;
  final String title;

  const QuickActionsPanel({
    super.key,
    required this.actions,
    this.title = 'Quick Actions',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade100, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                final action = actions[index];
                return InkWell(
                  onTap: action.onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: action.color.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: action.color.withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: action.color.withOpacity(0.15),
                          child: Icon(action.icon, color: action.color, size: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          action.label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey.shade800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// An entry item for the timeline-style Recent Activity Feed.
class PortalActivityItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  const PortalActivityItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });
}

/// A timeline list representing recent activity updates.
class RecentActivityFeed extends StatelessWidget {
  final List<PortalActivityItem> activities;
  final String title;

  const RecentActivityFeed({
    super.key,
    required this.activities,
    this.title = 'Recent Activity',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade100, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                final isLast = index == activities.length - 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline line and indicator dot
                    Column(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: activity.color.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              activity.icon,
                              color: activity.color,
                              size: 14,
                            ),
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 36,
                            color: Colors.grey.shade200,
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    // Activity details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  activity.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                activity.time,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activity.description,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// A vibrant, glassmorphic recommendation card showing contextual AI insights.
class AiInsightsCard extends StatelessWidget {
  final String heading;
  final List<String> suggestions;
  final IconData aiIcon;

  const AiInsightsCard({
    super.key,
    required this.heading,
    required this.suggestions,
    this.aiIcon = Icons.auto_awesome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5), Color(0xFF4338CA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(aiIcon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI ASSISTANT',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.7),
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      heading,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...suggestions.map((suggestion) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green.shade100,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      suggestion,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white.withOpacity(0.92),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
