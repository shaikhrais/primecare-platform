import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/theme/aura/01_I_aura_role_theme.dart';

class AuraSidebar extends ConsumerWidget {
  final Widget child;
  final String currentPath;
  final List<PrimeCareNavigationItem> items;

  const AuraSidebar({
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
    final auraTheme = AuraRoleTheme.resolve(ref);

    return Row(
      children: [
        buildSidebarContent(
          context,
          ref,
          currentIndex,
          layout,
          items,
          currentPath,
          auraTheme,
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
    AuraRoleTheme auraTheme,
  ) {
    final theme = Theme.of(context);
    final isExtended = layout.isExtended;
    final scale = layout.scaleFactor;
    final width = layout.sidebarWidth;

    final Map<String, List<PrimeCareNavigationItem>> groupedItems = {};
    for (var item in items) {
      String sectionName = item.section ?? 'navigation.sections.main';
      groupedItems.putIfAbsent(sectionName, () => []).add(item);
    }

    if (groupedItems.containsKey('navigation.sections.common_tools')) {
      final commonItems = groupedItems.remove(
        'navigation.sections.common_tools',
      )!;
      groupedItems['navigation.sections.common_tools'] = commonItems;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      width: width,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.8),
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.15),
            width: 1 * scale,
          ),
        ),
      ),
      child: Stack(
        children: [
          // Background Glow for selected item tracking (Advanced UI trick)
          _SidebarGlowBackground(auraTheme: auraTheme),

          Column(
            children: [
              SizedBox(height: 16 * scale),
              // Menu Items
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: isExtended ? 16 * scale : 10 * scale,
                  ),
                  children: [
                    ...groupedItems.entries.map((entry) {
                      return _AuraSidebarGroup(
                        title: entry.key,
                        items: entry.value,
                        currentPath: currentPath,
                        isExtended: isExtended,
                        scale: scale,
                        onTap: (item) => context.go(item.route),
                        auraTheme: auraTheme,
                      );
                    }),
                  ],
                ),
              ),

              // Footer: Aura Identity Card
              _AuraSidebarFooter(
                isExtended: isExtended,
                scale: scale,
                auraTheme: auraTheme,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuraSidebarGroup extends StatefulWidget {
  final String title;
  final List<PrimeCareNavigationItem> items;
  final String currentPath;
  final bool isExtended;
  final double scale;
  final void Function(PrimeCareNavigationItem) onTap;
  final AuraRoleTheme auraTheme;

  const _AuraSidebarGroup({
    required this.title,
    required this.items,
    required this.currentPath,
    required this.isExtended,
    required this.scale,
    required this.onTap,
    required this.auraTheme,
  });

  @override
  State<_AuraSidebarGroup> createState() => _AuraSidebarGroupState();
}

class _AuraSidebarGroupState extends State<_AuraSidebarGroup> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = true;
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
            borderRadius: BorderRadius.circular(10 * widget.scale),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10 * widget.scale,
                vertical: 14 * widget.scale,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title.tr().toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: widget.auraTheme.accentColor.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5 * widget.scale,
                      fontSize: 9 * widget.scale,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      LucideIcons.chevronRight,
                      size: 14 * widget.scale,
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.4,
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
              return _AuraSidebarMenuItem(
                item: item,
                isSelected: isSelected,
                isExtended: widget.isExtended,
                scale: widget.scale,
                onTap: () => widget.onTap(item),
                auraTheme: widget.auraTheme,
              );
            }).toList(),
          ),
          crossFadeState: (widget.isExtended && !_isExpanded)
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
          sizeCurve: Curves.easeInOutCubic,
        ),
        SizedBox(height: 8 * widget.scale),
      ],
    );
  }
}

class _AuraSidebarMenuItem extends StatefulWidget {
  final PrimeCareNavigationItem item;
  final bool isSelected;
  final bool isExtended;
  final double scale;
  final VoidCallback onTap;
  final AuraRoleTheme auraTheme;

  const _AuraSidebarMenuItem({
    required this.item,
    required this.isSelected,
    required this.isExtended,
    required this.scale,
    required this.onTap,
    required this.auraTheme,
  });

  @override
  State<_AuraSidebarMenuItem> createState() => _AuraSidebarMenuItemState();
}

class _AuraSidebarMenuItemState extends State<_AuraSidebarMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.only(bottom: 6 * widget.scale),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isExtended ? 14 * widget.scale : 0,
            vertical: 12 * widget.scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14 * widget.scale),
            gradient: widget.isSelected
                ? LinearGradient(
                    colors: widget.auraTheme.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : (_isHovered
                      ? LinearGradient(
                          colors: [
                            widget.auraTheme.accentColor.withValues(
                              alpha: 0.08,
                            ),
                            widget.auraTheme.accentColor.withValues(
                              alpha: 0.02,
                            ),
                          ],
                        )
                      : null),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: widget.auraTheme.accentColor.withValues(
                        alpha: 0.3,
                      ),
                      blurRadius: 12 * widget.scale,
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
                color: widget.isSelected
                    ? Colors.white
                    : (_isHovered
                          ? widget.auraTheme.accentColor
                          : theme.colorScheme.onSurfaceVariant),
              ),
              if (widget.isExtended) ...[
                SizedBox(width: 14 * widget.scale),
                Expanded(
                  child: Text(
                    widget.item.label.tr(),
                    style: GoogleFonts.plusJakartaSans(
                      color: widget.isSelected
                          ? Colors.white
                          : (_isHovered
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurfaceVariant),
                      fontSize: 14 * widget.scale,
                      fontWeight: widget.isSelected
                          ? FontWeight.w700
                          : FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.isSelected)
                  Container(
                    width: 6 * widget.scale,
                    height: 6 * widget.scale,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
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

class _AuraSidebarFooter extends ConsumerWidget {
  final bool isExtended;
  final double scale;
  final AuraRoleTheme auraTheme;

  const _AuraSidebarFooter({
    required this.isExtended,
    required this.scale,
    required this.auraTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final userName = authState.userName ?? 'User';
    final role = authState.role ?? 'Administrator';
    final initials = userName.isNotEmpty
        ? userName.substring(0, 1).toUpperCase()
        : 'U';

    return Container(
      padding: EdgeInsets.all(isExtended ? 16 * scale : 10 * scale),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.1),
            width: 1 * scale,
          ),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(isExtended ? 12 * scale : 0),
        decoration: isExtended
            ? BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.4,
                ),
                borderRadius: BorderRadius.circular(16 * scale),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withValues(
                    alpha: 0.1,
                  ),
                ),
              )
            : null,
        child: Row(
          mainAxisAlignment: isExtended
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            // User Avatar with Aura Glow
            Container(
              width: 44 * scale,
              height: 44 * scale,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: auraTheme.primaryGradient),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: auraTheme.accentColor.withValues(alpha: 0.2),
                    blurRadius: 8 * scale,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 13 * scale,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      role.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: auraTheme.accentColor,
                        fontSize: 9 * scale,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
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

class _SidebarGlowBackground extends StatelessWidget {
  final AuraRoleTheme auraTheme;
  const _SidebarGlowBackground({required this.auraTheme});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -100,
      left: -100,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              auraTheme.accentColor.withValues(alpha: 0.05),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class AuraSidebarDrawer extends ConsumerWidget {
  final String currentPath;
  final List<PrimeCareNavigationItem> items;

  const AuraSidebarDrawer({
    super.key,
    required this.currentPath,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final drawerLayout = LayoutConfig(
      tier: layout.tier,
      scaleFactor: layout.scaleFactor,
      sidebarWidth: 280.0 * layout.scaleFactor,
      spacingMultiplier: layout.spacingMultiplier,
      sidebarMode: SidebarMode.extended,
    );

    final auraTheme = AuraRoleTheme.resolve(ref);

    return Drawer(
      width: drawerLayout.sidebarWidth,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
          child: AuraSidebar.buildSidebarContent(
            context,
            ref,
            0,
            drawerLayout,
            items,
            currentPath,
            auraTheme,
          ),
        ),
      ),
    );
  }
}
