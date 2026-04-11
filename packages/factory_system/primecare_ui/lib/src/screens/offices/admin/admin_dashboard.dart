import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'admin.admin.dashboard.title',
        subtitle: 'admin.admin.dashboard.subtitle',
        provider: AdminDashboardScreenDataProvider('all'),
      );
}
