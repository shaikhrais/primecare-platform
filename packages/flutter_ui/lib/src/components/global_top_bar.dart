import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/primecare_ui.dart';

class GlobalTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;
  final String activeRole;
  final Widget? languageToggleWidget;

  const GlobalTopBar({super.key, required this.title, required this.onLogout, this.activeRole = 'psw_granular', this.languageToggleWidget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title, overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        ?languageToggleWidget,
        IconButton(
          icon: const Icon(Icons.assignment_ind_outlined),
          tooltip: 'Role SOP & Objectives Checklist',
          onPressed: () => context.push('/$activeRole/sow'),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle, size: 28),
          tooltip: 'Account Options',
          offset: const Offset(0, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onSelected: (value) {
            if (value == 'profile') {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  title: const Row(
                    children: [
                      Icon(Icons.account_circle, size: 36, color: Colors.indigo),
                      SizedBox(width: 12),
                      Text('Edit My Profile'),
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.indigo,
                          child: Icon(Icons.person, size: 40, color: Colors.white),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          initialValue: 'PrimeCare Administrator',
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: 'admin@primecare.com',
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: '+1 (555) 019-2831',
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    PrimeCareButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Colors.green),
                        );
                      },
                      text: 'Save Changes',
                    ),
                  ],
                ),
              );
            } else if (value == 'logout') {
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
                  content: const Text('Are you sure you want to terminate your current session? You will need to re-authenticate.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    PrimeCareButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        onLogout();
                      },
                      text: 'Sign Out',
                      isPrimary: false,
                    ),
                  ],
                ),
              );
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
            const PopupMenuItem<String>(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Sign Out', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
