import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../office/layouts/provider_top_bar.dart';
import '../../office/layouts/sidebar_layout.dart';
import '../../services/auth_service.dart';

class ProviderLayout extends ConsumerWidget {
  final Widget child;

  const ProviderLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The Provider Layout strictly enforces The Luminous Clinician aesthetics.
    // We dynamically pull the auth role to inject into the Top Bar.
    final role = ref.watch(authProvider).role ?? '';

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: ProviderTopBar(role: role),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return child;
          }
          return Row(
            children: [
              const SidebarLayout(), // The Luminous Glassmorphic Sidebar
              Expanded(child: child),
            ],
          );
        },
      ),
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < 900
              ? const Drawer(child: SidebarLayout())
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
