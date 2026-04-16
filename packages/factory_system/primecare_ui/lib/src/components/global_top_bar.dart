import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'primecare_button.dart';
import '../theme/design_system.dart';

class GlobalTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool showActions;
  final Widget? customLeft;
  final Widget? customCenter;
  final Widget? customRight;

  const GlobalTopBar({
    super.key,
    this.actions,
    this.showActions = true,
    this.customLeft,
    this.customCenter,
    this.customRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final theme = Theme.of(context);
    final scale = layout.scaleFactor;
    final isMobile = layout.tier == ResolutionTier.mob;
    final isTablet = layout.tier == ResolutionTier.tab;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 72.0 * scale,
          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.8),
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0 * scale),
            child: Container(
              height: 1 * scale,
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.1),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 24 * scale,
            ),
            child: Row(
              children: [
                // Left: Menu & Logo
                customLeft ??
                    _buildLeftSection(
                      context,
                      theme,
                      layout,
                      scale,
                      isMobile,
                      ref,
                    ),

                // Center: Search (Hidden on Mobile/Tablet as per HTML)
                if (!isMobile && !isTablet)
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 500 * scale),
                        child:
                            customCenter ??
                            _buildSearchBox(theme, layout, scale),
                      ),
                    ),
                  )
                else
                  const Spacer(),

                // Right: Actions & Profile
                if (showActions)
                  customRight ??
                      _buildRightSection(
                        context,
                        ref,
                        theme,
                        layout,
                        scale,
                        isMobile,
                        actions,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftSection(
    BuildContext context,
    ThemeData theme,
    LayoutConfig layout,
    double scale,
    bool isMobile,
    WidgetRef ref,
  ) {
    return Row(
      children: [
        if (isMobile) ...[
          IconButton(
            onPressed: () {
              // Toggle sidebar or open drawer
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(LucideIcons.menu, size: 24 * scale),
            style: IconButton.styleFrom(
              backgroundColor: PrimeCareDesignSystem.surfaceElevated,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10 * scale),
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
        ],
        Row(
          children: [
            if (!isMobile) ...[
              IconButton(
                onPressed: () {
                  final current = ref.read(sidebarModeProvider);
                  if (current == SidebarMode.extended) {
                    ref
                        .read(sidebarOverrideProvider.notifier)
                        .setMode(SidebarMode.minimal);
                  } else {
                    ref
                        .read(sidebarOverrideProvider.notifier)
                        .setMode(SidebarMode.extended);
                  }
                },
                icon: Icon(
                  layout.isExtended
                      ? LucideIcons.chevronLeft
                      : LucideIcons.menu,
                  size: 20 * scale,
                ),
                tooltip: layout.isExtended
                    ? 'Collapse Sidebar'
                    : 'Expand Sidebar',
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8 * scale),
                  ),
                ),
              ),
              SizedBox(width: 16 * scale),
            ],
            Container(
              width: 42 * scale,
              height: 42 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.tertiary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Center(
                child: Text(
                  'P',
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18 * scale,
                  ),
                ),
              ),
            ),
            if (!isMobile) ...[
              SizedBox(width: 12 * scale),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'PrimeCare',
                    style: TextStyle(
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Care Management Platform',
                    style: TextStyle(
                      fontSize: 12 * scale,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBox(ThemeData theme, LayoutConfig layout, double scale) {
    return Container(
      height: 44 * scale,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14 * scale),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search institutional workspace...',
          hintStyle: TextStyle(
            fontSize: 14 * scale,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          ),
          prefixIcon: Icon(
            LucideIcons.search,
            size: 16 * scale,
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10 * scale),
        ),
      ),
    );
  }

  Widget _buildRightSection(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    LayoutConfig layout,
    double scale,
    bool isMobile,
    List<Widget>? extraActions,
  ) {
    return Row(
      children: [
        if (extraActions != null) ...extraActions,
        if (!isMobile) ...[
          _buildIconButton(theme, LucideIcons.globe, scale),
          SizedBox(width: 14 * scale),
          _buildIconButton(theme, LucideIcons.messageSquare, scale),
          SizedBox(width: 14 * scale),
        ],
        _buildIconButton(theme, LucideIcons.bell, scale, hasBadge: true),
        SizedBox(width: 16 * scale),
        Container(
          height: 42 * scale,
          width: 1 * scale,
          color: theme.colorScheme.outlineVariant,
        ),
        SizedBox(width: 8 * scale),
        _buildProfileBox(context, ref, theme, scale, isMobile),
      ],
    );
  }

  Widget _buildIconButton(
    ThemeData theme,
    IconData icon,
    double scale, {
    bool hasBadge = false,
  }) {
    return Stack(
      children: [
        Container(
          width: 42 * scale,
          height: 42 * scale,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10 * scale),
          ),
          child: Icon(
            icon,
            size: 18 * scale,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (hasBadge)
          Positioned(
            top: 6 * scale,
            right: 6 * scale,
            child: Container(
              width: 10 * scale,
              height: 10 * scale,
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.surface,
                  width: 2 * scale,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileBox(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    double scale,
    bool isMobile,
  ) {
    final authState = ref.watch(authProvider);
    final userName = authState.userName ?? 'PrimeCare User';
    final role = authState.role ?? 'Administrator';
    final initials = userName.isNotEmpty
        ? userName.substring(0, 1).toUpperCase()
        : 'U';

    return InkWell(
      onTap: () => _showAccountMenu(context, ref, scale),
      child: Row(
        children: [
          Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16 * scale,
                ),
              ),
            ),
          ),
          if (!isMobile) ...[
            SizedBox(width: 10 * scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 12 * scale,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showAccountMenu(BuildContext context, WidgetRef ref, double scale) {
    // Current logic implementation for the PopupMenu integration
    final theme = Theme.of(context);
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000, 72 * scale, 24 * scale, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'profile',
          child: Text('User Profile'),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: Text(
            'Sign Out',
            style: TextStyle(color: theme.colorScheme.error),
          ),
        ),
      ],
    ).then((value) {
      if (!context.mounted) return;
      if (value == 'profile') context.push(CommonRoutes.globalProfile);
      if (value == 'logout') _handleLogout(context, ref, scale);
    });
  }

  void _handleLogout(BuildContext context, WidgetRef ref, double scale) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: PrimeCareDesignSystem.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: PrimeCareRadii.scaled(scale),
        ),
        title: Text(
          'Confirm Sign Out',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18 * scale),
        ),
        content: Text(
          'Are you sure you want to terminate your current session?',
          style: TextStyle(fontSize: 14 * scale),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          PrimeCareButton(
            label: 'Sign Out',
            type: PrimeCareButtonType.secondary,
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72.0); // Updated to match HTML height
}
