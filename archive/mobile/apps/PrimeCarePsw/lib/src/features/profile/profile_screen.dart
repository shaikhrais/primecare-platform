import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_psw/src/core/api/api_client.dart';
import 'package:primecare_psw/src/core/providers/auth_provider.dart';
import 'package:primecare_psw/src/core/theme/app_theme.dart';

/// Profile provider
final profileProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  return api.getProfile();
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: Text(
                      auth.fullName.isNotEmpty
                          ? auth.fullName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(auth.fullName,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,),),
                  const SizedBox(height: 4),
                  Text(auth.email,
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,),),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(auth.activeRole.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,),),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu items
            _menuCard(
                context, Icons.person_outline, 'Personal Information', () {},),
            _menuCard(context, Icons.school_outlined,
                'Training & Certifications', () {},),
            _menuCard(context, Icons.access_time, 'Timesheets', () {}),
            _menuCard(
                context, Icons.star_outline, 'Performance Reviews', () {},),
            _menuCard(context, Icons.description_outlined, 'Documents', () {}),
            _menuCard(context, Icons.settings_outlined, 'Settings', () {}),
            const SizedBox(height: 16),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final api = ref.read(apiClientProvider);
                  await api.logout();
                  ref.read(authStateProvider.notifier).logout();
                },
                icon: const Icon(Icons.logout, color: AppTheme.error),
                label: const Text('Sign Out',
                    style: TextStyle(color: AppTheme.error),),
                style: OutlinedButton.styleFrom(
                  side:
                      BorderSide(color: AppTheme.error.withValues(alpha: 0.3)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // App version
            Text('PrimeCare PSW v1.0.0',
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.3),),),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
      BuildContext context, IconData icon, String label, VoidCallback onTap,) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primary),
        title: Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
        trailing: Icon(Icons.chevron_right,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
