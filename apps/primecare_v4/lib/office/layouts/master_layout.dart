import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth_service.dart';
import 'sidebar_layout.dart';
import 'top_bar_layout.dart';
import 'provider_top_bar.dart';

class MasterLayout extends ConsumerWidget {
  final Widget child;
  const MasterLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authProvider).role?.toLowerCase() ?? '';

    // Condition check to see if we apply the advanced ProviderTopBar
    final isProvider =
        role.contains('rn') ||
        role.contains('rmt') ||
        role.contains('physio') ||
        role.contains('chiro');

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobileOrTablet = screenWidth < 900;

    return Scaffold(
      appBar: isProvider
          ? ProviderTopBar(role: role, isMobile: isMobileOrTablet)
          : const TopBarLayout(),
      drawer: isMobileOrTablet ? const Drawer(child: SidebarLayout()) : null,
      body: Row(
        children: [
          if (!isMobileOrTablet) const SidebarLayout(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
