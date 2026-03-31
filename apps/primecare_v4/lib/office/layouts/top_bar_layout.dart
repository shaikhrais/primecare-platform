import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth_service.dart';

class TopBarLayout extends ConsumerWidget implements PreferredSizeWidget {
  const TopBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('PrimeCare Office'),
      actions: [
        const Icon(Icons.notifications),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
             ref.read(authProvider.notifier).logout();
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
