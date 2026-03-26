import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/widgets/language_toggle_button.dart';

class GlobalTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;

  const GlobalTopBar({super.key, required this.title, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        const LanguageToggleButton(),
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
