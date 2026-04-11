import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/components/global_top_bar.dart';
import 'package:primecare_ui/src/components/universal_role_sidebar.dart';
import 'package:flutter_core/auth_service.dart';

class ProviderLayout extends ConsumerWidget {
  final Widget child;

  const ProviderLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The Provider Layout strictly enforces The Luminous Clinician aesthetics.
    // We dynamically pull the auth role to inject into the Top Bar.
    final role = ref.watch(authProvider).role ?? '';

    return UniversalRoleSidebar(
      currentPath: '/',
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: GlobalTopBar(
          title: 'Provider',
          activeRole: role,
          onLogout: () {
            ref.read(authProvider.notifier).logout();
          },
        ),
        body: child,
      ),
    );
  }
}
