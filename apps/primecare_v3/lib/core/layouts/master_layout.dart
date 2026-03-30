import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/theme_provider.dart';

class MasterLayout extends ConsumerWidget {
  final Widget? sidebar;
  final Widget? topbar;
  final Widget content;
  
  const MasterLayout({
    super.key,
    this.sidebar,
    this.topbar,
    required this.content,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeProvider).colors;
    return Scaffold(
      appBar: topbar != null ? PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: topbar!,
      ) : null,
      drawer: MediaQuery.of(context).size.width < 800 ? Drawer(child: sidebar) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (MediaQuery.of(context).size.width >= 800 && sidebar != null)
            SizedBox(
              width: 280,
              child: sidebar,
            ),
          Expanded(
            child: SafeArea(
              child: Container(
                color: colors.background, // Slate 50 background
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
