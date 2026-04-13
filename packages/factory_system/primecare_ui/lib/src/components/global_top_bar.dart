import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
import 'primecare_button.dart';
import '../theme/theme_tokens.dart';
import '../theme/design_system.dart';

class GlobalTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool showActions;

  const GlobalTopBar({super.key, this.actions, this.showActions = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(layoutProvider);
    final config = ref.watch(portalConfigProvider);
    final theme = Theme.of(context);

    final scale = layout.scaleFactor;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 56.0 * scale,
      backgroundColor: PrimeCareDesignSystem.surfaceElevated,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0 * scale),
        child: Divider(
          height: 1 * scale,
          thickness: 1 * scale,
          color: PrimeCareDesignSystem.borderSubtle,
        ),
      ),
      title: Text(
        config.title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
          fontSize: (theme.textTheme.titleMedium?.fontSize ?? 16.0) * scale,
        ),
      ),
      actions: showActions
          ? [
              ...?actions,
              IconButton(
                icon: Icon(Icons.notifications_none, size: 24 * scale),
                onPressed: () {},
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.account_circle, size: 28 * scale),
                tooltip: 'Account Options',
                offset: Offset(0, 48 * scale),
                shape: RoundedRectangleBorder(
                  borderRadius: PrimeCareRadii.scaled(scale),
                  side: BorderSide(color: PrimeCareDesignSystem.borderSubtle),
                ),
                onSelected: (value) {
                  if (value == 'profile') {
                    context.push('/profile');
                  } else if (value == 'logout') {
                    _handleLogout(context, ref, scale);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('User Profile'),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: theme.colorScheme.error,
                      ),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                ],
              ),
            ]
          : null,
    );
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
            child: Text('Cancel', style: TextStyle(fontSize: 14 * scale)),
          ),
          SizedBox(
            width: 120 * scale,
            child: PrimeCareButton(
              label: 'Sign Out',
              type: PrimeCareButtonType.secondary,
              onPressed: () {
                Navigator.pop(ctx);
                ref.read(authProvider.notifier).logout();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200.0); // Large enough bounds, AppBar toolbarHeight controls actual draw
}
