import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/auth_service.dart';

class GlobalTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onLogout;
  final String userRole;
  final Widget? languageToggleWidget;
  final List<Widget>? actions;
  final bool showActions;

  const GlobalTopBar({
    super.key,
    this.title,
    this.onLogout,
    required this.userRole,
    this.languageToggleWidget,
    this.actions,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        title ?? '${userRole.toUpperCase()} Portal',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: showActions
          ? [
              ...?actions,
              ?languageToggleWidget,
              IconButton(
                icon: const Icon(Icons.assignment_ind_outlined),
                tooltip: 'Role SOP & Objectives Checklist',
                onPressed: () => context.push('/$userRole/sow'),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.account_circle, size: 28),
                tooltip: 'Account Options',
                offset: const Offset(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
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
                    child: Row(
                      children: [
                        Icon(Icons.person_outline, color: Colors.grey.shade700),
                        const SizedBox(width: 12),
                        const Text('User Profile'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        const SizedBox(width: 12),
                        const Text(
                          'Sign Out',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 12),
            Text('Confirm Sign Out'),
          ],
        ),
        content: const Text(
          'Are you sure you want to terminate your current session? You will need to re-authenticate.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              if (onLogout != null) {
                onLogout!();
              } else {
                ref.read(authProvider.notifier).logout();
              }
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
