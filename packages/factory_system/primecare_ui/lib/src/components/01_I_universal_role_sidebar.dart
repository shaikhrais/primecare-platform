// Layer: 01_INFRASTRUCTURE
import 'dart:math' as math;
import 'package:go_router/go_router.dart';
import 'package:flutter_core/00_B_flutter_core.dart';

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

    // Tablet and Desktop layouts (Sidebar)
    return Row(
      children: [
        buildSidebarContent(
          context,
          ref,
          currentIndex,
          layout,
          items,
          currentPath,
        ),
        Expanded(
          child: Container(color: theme.colorScheme.surface, child: child),
        ),
      ],
    );
  }

  static Widget buildSidebarContent(
    BuildContext context,
    WidgetRef ref,
    int currentIndex,
    LayoutConfig layout,
    List<PrimeCareNavigationItem> items,
    String currentPath,
  ) {
    final theme = Theme.of(context);
    final isExtended = layout.isExtended;
    final scale = layout.scaleFactor;

    // Dynamic width based on Grid Columns
    final width = layout.sidebarWidth;

    // Group items dynamically by their section
    final Map<String, List<PrimeCareNavigationItem>> groupedItems = {};

    for (var item in items) {
      String sectionName = item.section ?? 'Main';

      if (!groupedItems.containsKey(sectionName)) {
        groupedItems[sectionName] = [];
      }
      groupedItems[sectionName]!.add(item);
    }

    // Ensure 'Common Tools' is always moved to the very bottom, if it exists
    if (groupedItems.containsKey('Common Tools')) {
      final commonItems = groupedItems.remove('Common Tools')!;
      groupedItems['Common Tools'] = commonItems;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 12 * scale), // Replaced Logo Header
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isExtended ? 16 * scale : 8 * scale,
              ),
              children: [
                ...groupedItems.entries.map((entry) {
                  return _SidebarGroup(
                    title: entry.key,
                    items: entry.value,
                    currentPath: currentPath,
                    isExtended: isExtended,
                    scale: scale,
                    onTap: (item) => context.go(item.route),
                    // Auto-expand if the current path is in this group
                    startsExpanded: entry.value.any(
                      (item) => item.route == currentPath,
                    ),
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
      sidebarMode: SidebarMode.extended, // Force extended for the drawer!
    );

    return Drawer(
      width: drawerLayout.sidebarWidth,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: UniversalRoleSidebar.buildSidebarContent(
          context,
          ref,
          currentIndex,
          drawerLayout,
          items,
          currentPath,
        ),
      ),
    );
  }
}

class _SidebarGroup extends StatefulWidget {
  final String title;
  final List<PrimeCareNavigationItem> items;
  final String currentPath;
  final bool isExtended;
  final double scale;
  final void Function(PrimeCareNavigationItem) onTap;
  final bool startsExpanded;

  const _SidebarGroup({
    required this.title,
    required this.items,
    required this.currentPath,
    required this.isExtended,
    required this.scale,
    required this.onTap,
    this.startsExpanded = true,
  });

  @override
  State<_SidebarGroup> createState() => _SidebarGroupState();
}

class _SidebarGroupState extends State<_SidebarGroup> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.startsExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isExtended)
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(8 * widget.scale),
            child: Padding(
              padding: EdgeInsets.only(
                left: 10 * widget.scale,
                top: 18 * widget.scale,
                bottom: 8 * widget.scale,
                right: 8 * widget.scale,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.5,
                      ),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5 * widget.scale,
                      fontSize: 10 * widget.scale,
                    ),
                  ),
                  Transform.rotate(
                    angle: _isExpanded ? math.pi / 2 : 0,
                    child: Icon(
                      Icons.chevron_right,
                      size: 14 * widget.scale,
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Column(
            children: widget.items.map((item) {
              final isSelected = item.route == widget.currentPath;
              return _SidebarMenuItem(
                item: item,
                isSelected: isSelected,
                isExtended: widget.isExtended,
                scale: widget.scale,
                onTap: () => widget.onTap(item),
              );
            }).toList(),
          ),
          crossFadeState: (widget.isExtended && !_isExpanded)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 250),
        ),
      ],
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
      backgroundColor = theme.colorScheme.primary;
      iconColor = theme.colorScheme.onPrimary;
      textColor = theme.colorScheme.onPrimary;
    } else if (_isHovered) {
      backgroundColor = theme.colorScheme.primary.withValues(alpha: 0.08);
      iconColor = theme.colorScheme.primary;
      textColor = theme.colorScheme.primary;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(bottom: 4 * widget.scale),
          padding: EdgeInsets.symmetric(
            horizontal: 14 * widget.scale,
            vertical: 11 * widget.scale,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12 * widget.scale),
            gradient: widget.isSelected
                ? LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 10 * widget.scale,
                      offset: Offset(0, 4 * widget.scale),
                    ),
                  ]
                : [],
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
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(isExtended ? 12 * scale : 0),
        decoration: isExtended
            ? BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
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
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials.toUpperCase(),
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
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
