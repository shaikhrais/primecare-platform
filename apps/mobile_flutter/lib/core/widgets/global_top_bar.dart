import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme_provider.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'language_toggle_button.dart';
import '../api_client.dart';

class GlobalTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLogout;

  const GlobalTopBar({
    super.key,
    required this.title,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    return PrimeCareNavBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.35),
      title: PrimeCareText(
        title, 
        style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color ?? Theme.of(context).iconTheme.color, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -0.5)
      ),
      actions: [
                const LanguageToggleButton(),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Toggle Theme',
          icon: PrimeCareIcon(isDark ? Icons.light_mode : Icons.dark_mode, color: Theme.of(context).iconTheme.color),
          onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'System Alerts',
          icon: PrimeCareIcon(Icons.warning_amber_rounded, color: Theme.of(context).iconTheme.color),
          onPressed: () {},
        ),
        IconButton(
          tooltip: 'Notifications',
          icon: PrimeCareIcon(Icons.notifications_none_rounded, color: Theme.of(context).iconTheme.color),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: CircleAvatar(
            radius: 17,
            backgroundColor: Color(0xFF0EA5E9),
            child: PrimeCareText('Pr', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          onSelected: (value) async {
            if (value == 'profile') {
              context.push('/psw/profile'); // Fallback globally
            } else if (value == 'logout') {
              if (onLogout != null) {
                onLogout!();
              } else {
                await apiClient.logout();
                if (context.mounted) context.go('/login');
              }
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'profile',
              child: ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('User Profile'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Sign Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
