import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/flutter_core.dart';

class UniversalRoleSidebar extends ConsumerWidget {
  final Widget child;
  final String currentPath;
  final List<PrimeCareNavigationItem> items;

  const UniversalRoleSidebar({
    super.key,
    required this.child,
    required this.currentPath,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = items.indexWhere((item) => item.route == currentPath);
    if (currentIndex == -1) currentIndex = 0;

    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    // Mobile layout
    if (layout.tier == ResolutionTier.mob) {
      return Scaffold(
        body: child,
        bottomNavigationBar: items.isNotEmpty
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                selectedItemColor: theme.colorScheme.primary,
                unselectedItemColor: theme.disabledColor,
                backgroundColor: theme.colorScheme.surface,
                elevation: 8,
                onTap: (index) {
                  if (index < items.length) context.go(items[index].route);
                },
                items: items.map((item) {
                  final iconSize = 24.0 * layout.scaleFactor;
                  return BottomNavigationBarItem(
                    icon: Icon(item.icon, size: iconSize),
                    activeIcon: item.activeIcon != null
                        ? Icon(item.activeIcon, size: iconSize)
                        : null,
                    label: item.label,
                  );
                }).toList(),
              )
            : null,
      );
    }

    // Tablet and Desktop layouts (Sidebar)
    return Scaffold(
      body: Row(
        children: [
          buildSidebarContent(context, ref, currentIndex, layout, items),
          Expanded(
            child: Container(color: theme.colorScheme.surface, child: child),
          ),
        ],
      ),
    );
  }

  static Widget buildSidebarContent(
    BuildContext context,
    WidgetRef ref,
    int currentIndex,
    LayoutConfig layout,
    List<PrimeCareNavigationItem> items,
  ) {
    final theme = Theme.of(context);
    final isExtended = layout.isExtended;
    final scale = layout.scaleFactor;
    final width = isExtended ? 260.0 * scale : 82.0 * scale;

    // Group items into Role Specific and Common
    final Map<String, List<PrimeCareNavigationItem>> groupedItems = {
      'Role Specific': [],
      'Common': [],
    };
    for (var item in items) {
      if (item.section == 'Common Tools' ||
          item.section == 'Common' ||
          item.route.startsWith('/common/') &&
              item.route != '/common/user-management') {
        groupedItems['Common']!.add(item);
      } else {
        groupedItems['Role Specific']!.add(item);
      }
    }
    groupedItems.removeWhere((key, value) => value.isEmpty);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo Header
          _SidebarHeader(isExtended: isExtended, scale: scale),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isExtended ? 16 * scale : 8 * scale,
              ),
              children: [
                ...groupedItems.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isExtended)
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10 * scale,
                            top: 18 * scale,
                            bottom: 8 * scale,
                          ),
                          child: Text(
                            entry.key.toUpperCase(),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.5),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5 * scale,
                              fontSize: 10 * scale,
                            ),
                          ),
                        ),
                      ...entry.value.map((item) {
                        final isSelected = items.indexOf(item) == currentIndex;
                        return _SidebarMenuItem(
                          item: item,
                          isSelected: isSelected,
                          isExtended: isExtended,
                          scale: scale,
                          onTap: () => context.go(item.route),
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
          ),

          // Footer (User Card)
          _SidebarFooter(isExtended: isExtended, scale: scale),
        ],
      ),
    );
  }
}

class UniversalRoleDrawer extends ConsumerWidget {
  final String currentPath;
  final List<PrimeCareNavigationItem> items;

  const UniversalRoleDrawer({
    super.key,
    required this.currentPath,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = items.indexWhere((item) => item.route == currentPath);
    if (currentIndex == -1) currentIndex = 0;

    final layout = ref.watch(layoutProvider);
    final drawerLayout = LayoutConfig(
      tier: layout.tier,
      scaleFactor: layout.scaleFactor,
      sidebarWidth: 260.0 * layout.scaleFactor,
      spacingMultiplier: layout.spacingMultiplier,
      isExtended: true, // Force extended for the drawer!
    );

    return Drawer(
      width: 260.0 * layout.scaleFactor,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: UniversalRoleSidebar.buildSidebarContent(
          context,
          ref,
          currentIndex,
          drawerLayout,
          items,
        ),
      ),
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  final bool isExtended;
  final double scale;

  const _SidebarHeader({required this.isExtended, required this.scale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        16 * scale,
        24 * scale,
        16 * scale,
        24 * scale,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      margin: EdgeInsets.only(bottom: 20 * scale),
      child: Row(
        mainAxisAlignment: isExtended
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          // Logo Icon (Gradient P)
          Container(
            width: 44 * scale,
            height: 44 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12 * scale),
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'P',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20 * scale,
              ),
            ),
          ),
          if (isExtended) ...[
            SizedBox(width: 12 * scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PrimeCare',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18 * scale,
                    height: 1.1,
                  ),
                ),
                Text(
                  'Care Management',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.6,
                    ),
                    fontSize: 11 * scale,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SidebarMenuItem extends StatefulWidget {
  final PrimeCareNavigationItem item;
  final bool isSelected;
  final bool isExtended;
  final double scale;
  final VoidCallback onTap;

  const _SidebarMenuItem({
    required this.item,
    required this.isSelected,
    required this.isExtended,
    required this.scale,
    required this.onTap,
  });

  @override
  State<_SidebarMenuItem> createState() => _SidebarMenuItemState();
}

class _SidebarMenuItemState extends State<_SidebarMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor = Colors.transparent;
    Color iconColor = theme.colorScheme.onSurfaceVariant;
    Color textColor = theme.colorScheme.onSurface;

    if (widget.isSelected) {
      backgroundColor = const Color(0xFF2563EB);
      iconColor = Colors.white;
      textColor = Colors.white;
    } else if (_isHovered) {
      backgroundColor = const Color(0xFFEFF6FF);
      iconColor = const Color(0xFF2563EB);
      textColor = const Color(0xFF2563EB);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: EdgeInsets.only(bottom: 6 * widget.scale),
          padding: EdgeInsets.symmetric(
            horizontal: 14 * widget.scale,
            vertical: 12 * widget.scale,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12 * widget.scale),
          ),
          child: Row(
            mainAxisAlignment: widget.isExtended
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(
                widget.isSelected && widget.item.activeIcon != null
                    ? widget.item.activeIcon
                    : widget.item.icon,
                size: 20 * widget.scale,
                color: iconColor,
              ),
              if (widget.isExtended) ...[
                SizedBox(width: 12 * widget.scale),
                Expanded(
                  child: Text(
                    widget.item.label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15 * widget.scale,
                      fontWeight: widget.isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarFooter extends ConsumerWidget {
  final bool isExtended;
  final double scale;

  const _SidebarFooter({required this.isExtended, required this.scale});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final role = authState.role ?? 'Administrator';

    final userName = authState.userName ?? 'PrimeCare User';
    final initials = userName.isNotEmpty
        ? userName.substring(0, 1).toUpperCase()
        : 'U';

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20 * scale,
        horizontal: 16 * scale,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(isExtended ? 12 * scale : 0),
        decoration: isExtended
            ? BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(14 * scale),
              )
            : null,
        child: Row(
          mainAxisAlignment: isExtended
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            // Avatar
            Container(
              width: 44 * scale,
              height: 44 * scale,
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * scale,
                ),
              ),
            ),
            if (isExtended) ...[
              SizedBox(width: 12 * scale),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userName,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14 * scale,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      role,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.6,
                        ),
                        fontSize: 12 * scale,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
