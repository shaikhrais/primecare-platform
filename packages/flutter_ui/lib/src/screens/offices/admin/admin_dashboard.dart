import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('admin.admin.dashboard.title'.tr()),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            key: const Key('data-status-id=shared-global-admin-action-1'),
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.admin_panel_settings,
              size: 80,
              color: Color(0xFFBB86FC),
            ),
            const SizedBox(height: 24),
            Text(
              'admin.admin.dashboard.subtitle'.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text('Manage platform settings, roles, and metrics here.'),
          ],
        ),
      ),
    );
  }
}
