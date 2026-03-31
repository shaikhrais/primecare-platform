import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth_service.dart';
import 'sidebar_layout.dart';
import 'top_bar_layout.dart';
import 'provider_top_bar.dart';

class MasterLayout extends ConsumerWidget {
  final Widget child;
  const MasterLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authProvider).role?.toLowerCase() ?? '';
    
    // Condition check to see if we apply the advanced ProviderTopBar
    final isProvider = role.contains('rn') || role.contains('rmt') || role.contains('physio') || role.contains('chiro');

    return Scaffold(
      appBar: isProvider ? ProviderTopBar(role: role) : const TopBarLayout(),
      body: Row(
        children: [
          const SidebarLayout(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
