import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlobalTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;

  const GlobalTopBar({super.key, required this.title, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
          icon: const Icon(Icons.check_box),
          tooltip: 'Active Daily Tasks & Quick Forms',
          onPressed: () {
            String role = 'psw';
            final currentPath = GoRouterState.of(context).uri.toString();
            if (currentPath.startsWith('/rn')) role = 'rn';
            else if (currentPath.startsWith('/coordinator')) role = 'coordinator';
            else if (currentPath.startsWith('/manager')) role = 'manager';
            else if (currentPath.startsWith('/admin')) role = 'admin';
            else if (currentPath.startsWith('/gm')) role = 'gm';
            else if (currentPath.startsWith('/mt')) role = 'mt';
            else if (currentPath.startsWith('/client')) role = 'client';
            else if (currentPath.startsWith('/superuser')) role = 'superuser';
            else if (currentPath.startsWith('/scrum')) role = 'scrum';
            
            context.push('/universal/$role/dailyTasks');
          },
        ),
        IconButton(
          icon: const Icon(Icons.assignment_ind_outlined),
          tooltip: 'Role SOP & Objectives Checklist',
          onPressed: () => context.push('/role-sow'),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
        IconButton(icon: const Icon(Icons.logout), onPressed: onLogout),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
