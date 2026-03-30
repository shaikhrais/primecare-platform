import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../auth/auth_provider.dart';
import '../providers/theme_provider.dart';

class CommonTopbarEngine extends ConsumerWidget {
  final String screenTitle;
  final VoidCallback onLanguageToggle;
  final VoidCallback onNotificationsTap;

  const CommonTopbarEngine({
    super.key,
    required this.screenTitle,
    required this.onLanguageToggle,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userName = authState.userName ?? 'Guest';
    final roleId = authState.roleId ?? 'Unassigned';
    final colors = ref.watch(themeProvider).colors;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(bottom: BorderSide(color: colors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Breadcrumb / Title Area
          Text(
            screenTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colors.textMain,
            ),
          ),
          
          const Spacer(),
          
          // Language Switcher
          Container(
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: colors.border),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: onLanguageToggle,
              child: Row(
                children: [
                  Icon(Icons.language, size: 16, color: colors.textMuted),
                  const SizedBox(width: 6),
                  Text('EN/FR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: colors.textMain)),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Notifications
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: colors.textMuted),
            onPressed: onNotificationsTap,
          ),
          
          const SizedBox(width: 16),
          
          // Care Profile Menu Popup
          PopupMenuButton<int>(
            offset: const Offset(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            color: colors.surface,
            position: PopupMenuPosition.under,
            tooltip: 'Care Profile',
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                enabled: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: colors.accent,
                        child: Icon(Icons.person, color: colors.surface),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colors.textMain)),
                          Text(roleId.replaceAll('_', ' ').toUpperCase(), style: TextStyle(fontSize: 13, color: colors.textMuted)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.person_outline, size: 20, color: colors.textMain),
                    const SizedBox(width: 12),
                    Text('My Profile', style: TextStyle(fontWeight: FontWeight.w600, color: colors.textMain)),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, size: 20, color: colors.textMain),
                    const SizedBox(width: 12),
                    Text('Account Settings', style: TextStyle(fontWeight: FontWeight.w600, color: colors.textMain)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: const [
                    Icon(Icons.logout_rounded, size: 20, color: Colors.redAccent),
                    SizedBox(width: 12),
                    Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                context.push('/profile');
              } else if (value == 2) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account Settings coming soon!')));
              } else if (value == 3) {
                context.go('/logged_out');
                ref.read(authProvider.notifier).logout();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.border),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                ]
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colors.accent,
                    radius: 16,
                    child: Icon(Icons.person, color: colors.surface, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(userName.split(' ').first, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: colors.textMain)),
                  const SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, size: 18, color: colors.textMuted),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
