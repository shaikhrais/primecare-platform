import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';

class GlobalTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool showActions;

  const GlobalTopBar({
    super.key,
    this.actions,
    this.showActions = true,
  });

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
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(height: 1, color: theme.colorScheme.outline),
      ),
      title: Text(
        config.title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
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
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: theme.colorScheme.outline),
                ),
                onSelected: (value) {
                  if (value == 'profile') {
                    context.push('/profile');
                  } else if (value == 'logout') {
                    _handleLogout(context, ref);
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
                      leading: Icon(Icons.logout, color: theme.colorScheme.error),
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

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: const Text('Confirm Sign Out'),
        content: const Text(
          'Are you sure you want to terminate your current session?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(authProvider.notifier).logout();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0 + 1.0); // Logic will handle internal scaling
}
