import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider_top_bar_config.dart';
import 'role_quick_actions.dart';
import '../components/glass_surface.dart';
import '../../services/auth_service.dart';

class ProviderTopBar extends ConsumerWidget implements PreferredSizeWidget {
  final String role;
  
  const ProviderTopBar({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Normalization mapping for standard role badge names
    String mappedRole = role;
    if (role.toLowerCase().contains('rn')) mappedRole = 'RN';
    if (role.toLowerCase().contains('rmt')) mappedRole = 'RMT';
    if (role.toLowerCase().contains('physio')) mappedRole = 'Physio';
    if (role.toLowerCase().contains('chiro')) mappedRole = 'Chiro';

    final extraChips = ProviderTopBarConfig.roleExtraChips[mappedRole] ?? [];

    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      forceMaterialTransparency: true,
      flexibleSpace: const GlassSurface(
        borderRadius: 0,
        hasGhostBorder: false,
        child: SizedBox.expand(),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            // Left Section: Logo, Title, Badge
            const Icon(Icons.health_and_safety, color: Color(0xFF006565), size: 28),
            const SizedBox(width: 8),
            const Text(
              'PrimeCare Provider Portal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF006565),
                borderRadius: BorderRadius.circular(50)
              ),
              child: Text(
                mappedRole.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(width: 32),

            // Center Section: Global Search
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search patients, charts, appointments...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Right Section
        IconButton(
          icon: const Badge(child: Icon(Icons.notifications_outlined)),
          tooltip: 'Notifications',
          onPressed: () {},
        ),
        IconButton(
          icon: const Badge(child: Icon(Icons.chat_bubble_outline)),
          tooltip: 'Messages',
          onPressed: () {},
        ),
        
        // Quick Add Component
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RoleQuickActionsMenu(role: mappedRole),
        ),

        IconButton(
          icon: const Icon(Icons.help_outline),
          tooltip: 'Help / Policy',
          onPressed: () {},
        ),

        // Profile Menu Component
        PopupMenuButton<String>(
          icon: const CircleAvatar(
            radius: 16,
            child: Icon(Icons.person, size: 20),
          ),
          onSelected: (value) {
            if (value == 'Logout') {
              ref.read(authProvider.notifier).logout();
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'Profile', child: Text('My Profile')),
            PopupMenuItem(value: 'Schedule', child: Text('My Schedule')),
            PopupMenuItem(value: 'Settings', child: Text('Settings')),
            PopupMenuDivider(),
            PopupMenuItem(value: 'Logout', child: Text('Logout', style: TextStyle(color: Colors.red))),
          ],
        ),
        const SizedBox(width: 16),
      ],

      // Bottom Section: Extra quick jump chips
      bottom: extraChips.isNotEmpty ? PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
           height: 48,
           alignment: Alignment.centerLeft,
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
           decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.2)))
           ),
           child: Row(
             children: extraChips.map((chipText) => Padding(
               padding: const EdgeInsets.only(right: 8.0),
               child: ActionChip(
                 label: Text(chipText, style: const TextStyle(fontSize: 12)),
                 onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening: $chipText')));
                 },
               ),
             )).toList(),
           ),
        ),
      ) : null,
    );
  }

  @override
  Size get preferredSize {
    // Return standard height + chips row height if role has extra chips
    bool hasVal = false;
    final r = role.toLowerCase();
    if (r.contains('rn') || r.contains('rmt') || r.contains('physio') || r.contains('chiro')) {
        hasVal = true;
    }
    return Size.fromHeight(kToolbarHeight + (hasVal ? 48 : 0));
  }
}
