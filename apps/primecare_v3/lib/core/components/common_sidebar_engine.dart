import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonSidebarEngine extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.white,
      child: Column(
        children: [
          // Branding
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              children: [
                const Icon(Icons.health_and_safety, color: Colors.blueAccent, size: 28),
                const SizedBox(width: 12),
                Text(
                  'PrimeCare V3',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
          // Office/Role Context Banner
          Container(
            color: const Color(0xFFF8FAFC),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text('Office: $officeCode', style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                 const SizedBox(height: 4),
                 Text(roleTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
          ),
          
          const Divider(height: 1),

          // Menu Loop
          Expanded(
            child: ListView.builder(
              itemCount: menus.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                final menu = menus[index];
                final isActive = activeRoute.startsWith(menu.route);
                return _buildMenuItem(context, menu, isActive);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, SidebarMenuConfig menu, bool isActive) {
    return InkWell(
      onTap: () => context.go(menu.route),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(menu.icon, color: isActive ? Colors.blue : Colors.grey.shade600, size: 22),
            const SizedBox(width: 16),
            Text(
              menu.label,
              style: TextStyle(
                color: isActive ? Colors.blue.shade700 : Colors.black87,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            if (menu.badgeCount != null && menu.badgeCount! > 0) ...[
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '\${menu.badgeCount}',
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
