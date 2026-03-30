import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';

class CommonSidebarEngine extends ConsumerWidget {
  final String activeRoute;
  final List<SidebarMenuConfig> menus;
  final String roleTitle;
  final String officeCode;

  const CommonSidebarEngine({
    super.key,
    required this.activeRoute,
    required this.menus,
    required this.roleTitle,
    required this.officeCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeProvider).colors;

    return Container(
      width: 280,
      color: colors.surface,
      child: Column(
        children: [
          // Branding
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.background)),
            ),
            child: Row(
              children: [
                Icon(Icons.health_and_safety, color: colors.accent, size: 28),
                const SizedBox(width: 12),
                Text(
                  'PrimeCare V3',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: colors.textMain),
                ),
              ],
            ),
          ),
          
          // Office/Role Context Banner
          Container(
            color: colors.surfaceVariant,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Office: $officeCode', style: TextStyle(fontSize: 12, color: colors.textMuted, fontWeight: FontWeight.bold)),
                 const SizedBox(height: 4),
                 Text(roleTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: colors.textMain)),
              ],
            ),
          ),
          
          Divider(height: 1, color: colors.border),

          // Menu Loop
          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                final menu = menus[index];
                final isActive = activeRoute.startsWith(menu.route);
                return _buildMenuItem(context, menu, isActive, colors);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, SidebarMenuConfig menu, bool isActive, var colors) {
    return InkWell(
      onTap: () => context.go(menu.route),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? colors.accent.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(menu.icon, color: isActive ? colors.accent : colors.textMuted, size: 22),
            const SizedBox(width: 16),
            Text(
              menu.label,
              style: TextStyle(
                color: isActive ? colors.accent : colors.textMain,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            if (menu.badgeCount != null && menu.badgeCount! > 0) ...[
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colors.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${menu.badgeCount}',
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class SidebarMenuConfig {
  final String label;
  final String route;
  final IconData icon;
  final int? badgeCount;

  const SidebarMenuConfig({
    required this.label,
    required this.route,
    required this.icon,
    this.badgeCount,
  });
}
