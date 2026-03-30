import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/providers/theme_provider.dart';

class GlobalProfilePageWidget extends ConsumerWidget {
  const GlobalProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userName = authState.userName ?? 'Guest';
    final roleId = authState.roleId ?? 'Unassigned';

    final themeState = ref.watch(themeProvider);
    final colors = themeState.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        backgroundColor: colors.surface,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textSecondary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar and Hero Unit
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: colors.primary,
                        child: const Icon(Icons.person, color: Colors.white, size: 48),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        userName,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: colors.textPrimary),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          roleId.toUpperCase().replaceAll('_', ' '),
                          style: TextStyle(fontWeight: FontWeight.w600, color: colors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Account Settings
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Settings',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.textPrimary),
                      ),
                      const SizedBox(height: 24),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.email_outlined, color: colors.textPrimary),
                        ),
                        title: Text('Email Address', style: TextStyle(fontWeight: FontWeight.w600, color: colors.textPrimary)),
                        subtitle: Text('$roleId@primecare.com', style: TextStyle(color: colors.textSecondary)),
                        trailing: TextButton(onPressed: () {}, child: Text('Edit', style: TextStyle(color: colors.primary))),
                      ),
                      const Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.lock_outline, color: colors.textPrimary),
                        ),
                        title: Text('Password', style: TextStyle(fontWeight: FontWeight.w600, color: colors.textPrimary)),
                        subtitle: Text('Last changed 3 months ago', style: TextStyle(color: colors.textSecondary)),
                        trailing: TextButton(onPressed: () {}, child: Text('Reset', style: TextStyle(color: colors.primary))),
                      ),
                      const Divider(),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.notifications_active_outlined, color: colors.textPrimary),
                        ),
                        title: Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w600, color: colors.textPrimary)),
                        subtitle: Text('Receive alerts for urgent dispatches', style: TextStyle(color: colors.textSecondary)),
                        value: true,
                        activeColor: colors.primary,
                        onChanged: (val) {},
                      ),
                      const Divider(),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.dark_mode_outlined, color: colors.textPrimary),
                        ),
                        title: Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600, color: colors.textPrimary)),
                        subtitle: Text('Toggle system theme mode', style: TextStyle(color: colors.textSecondary)),
                        value: themeState.mode == ThemeMode.dark,
                        activeColor: colors.primary,
                        onChanged: (val) {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Danger Zone
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: colors.error.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.error.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Danger Zone',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.error),
                      ),
                      const SizedBox(height: 16),
                      Text('Deleting your internal corporate account requires HR approval and cannot be instantly undone.', style: TextStyle(color: colors.textSecondary)),
                      const SizedBox(height: 24),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.error,
                          side: BorderSide(color: colors.error),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text('Request Account Deletion'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
