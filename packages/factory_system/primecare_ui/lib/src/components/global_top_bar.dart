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

  const GlobalTopBar({super.key, this.actions, this.showActions = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final theme = Theme.of(context);
    final scale = layout.scaleFactor;
    final isMobile = layout.tier == ResolutionTier.mob;
    final isTablet = layout.tier == ResolutionTier.tab;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 72.0 * scale,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0 * scale),
        child: Container(
          height: 1 * scale,
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.15),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24 * scale),
        child: Row(
          children: [
            // Left: Menu & Logo
            _buildLeftSection(context, layout, scale, isMobile),

            // Center: Search (Hidden on Mobile/Tablet as per HTML)
            if (!isMobile && !isTablet)
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 500 * scale),
                    child: _buildSearchBox(layout, scale),
                  ),
                ),
              )
            else
              const Spacer(),

            // Right: Actions & Profile
            _buildRightSection(context, ref, layout, scale, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSection(
    BuildContext context,
    LayoutConfig layout,
    double scale,
    bool isMobile,
  ) {
    return Row(
      children: [
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
        SizedBox(width: isMobile ? 8 : 16 * scale),
        Row(
          children: [
            Container(
              width: 42 * scale,
              height: 42 * scale,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Center(
                child: Text(
                  'P',
                  style: TextStyle(
                    color: Colors.white,
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
                      color: const Color(0xFF111827),
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Care Management Platform',
                    style: TextStyle(
                      fontSize: 12 * scale,
                      color: const Color(0xFF6B7280),
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

  Widget _buildSearchBox(LayoutConfig layout, double scale) {
    return Container(
      height: 44 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search clients, caregivers, shifts...',
          hintStyle: TextStyle(
            fontSize: 14 * scale,
            color: const Color(0xFF6B7280),
          ),
          prefixIcon: Icon(
            LucideIcons.search,
            size: 16 * scale,
            color: const Color(0xFF6B7280),
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
    LayoutConfig layout,
    double scale,
    bool isMobile,
  ) {
    return Row(
      children: [
        if (!isMobile) ...[
          _buildIconButton(LucideIcons.globe, scale),
          SizedBox(width: 14 * scale),
          _buildIconButton(LucideIcons.messageSquare, scale),
          SizedBox(width: 14 * scale),
        ],
        _buildIconButton(LucideIcons.bell, scale, hasBadge: true),
        SizedBox(width: 16 * scale),
        Container(
          height: 42 * scale,
          width: 1 * scale,
          color: const Color(0xFFE5E7EB),
        ),
        SizedBox(width: 8 * scale),
        _buildProfileBox(context, ref, scale, isMobile),
      ],
    );
  }

  Widget _buildIconButton(
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
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(10 * scale),
          ),
          child: Icon(icon, size: 18 * scale, color: const Color(0xFF1F2937)),
        ),
        if (hasBadge)
          Positioned(
            top: 6 * scale,
            right: 6 * scale,
            child: Container(
              width: 10 * scale,
              height: 10 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2 * scale),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileBox(
    BuildContext context,
    WidgetRef ref,
    double scale,
    bool isMobile,
  ) {
    return InkWell(
      onTap: () => _showAccountMenu(context, ref, scale),
      child: Row(
        children: [
          Container(
            width: 42 * scale,
            height: 42 * scale,
            decoration: const BoxDecoration(
              color: Color(0xFF2563EB),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'MS',
                style: TextStyle(
                  color: Colors.white,
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
                  'Mohammed',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
                Text(
                  'Administrator',
                  style: TextStyle(
                    fontSize: 12 * scale,
                    color: const Color(0xFF6B7280),
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
      if (value == 'profile') context.push('/profile');
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
