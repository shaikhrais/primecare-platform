import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;
  final bool isSelected;

  const NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
    this.isSelected = false,
  });
}

class PrimeCareSidebar extends StatelessWidget {
  final String userName;
  final String userRole;
  final String? userAvatarUrl;
  final List<NavigationItem> items;
  final Widget? footer;

  const PrimeCareSidebar({
    super.key,
    required this.userName,
    required this.userRole,
    this.userAvatarUrl,
    required this.items,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Drawer(
      backgroundColor: theme.colors.surface,
      child: Column(
        children: [
          const SizedBox(height: 60),
          _buildProfileSection(theme),
          Divider(color: theme.colors.divider),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _buildNavItem(context, item);
              },
            ),
          ),
          if (footer != null) footer!,
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileSection(PrimeThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
            backgroundImage: NetworkImage(
              userAvatarUrl ?? 'https://api.dicebear.com/7.x/avataaars/png?seed=$userName',
            ),
          ),
          const SizedBox(height: 16),
          Text(userName, style: theme.typography.h3),
          Text(
            userRole,
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, NavigationItem item) {
    final theme = context.theme;
    return ListTile(
      leading: Icon(
        item.icon,
        color: item.isSelected ? theme.colors.primary : theme.colors.onSurfaceVariant,
      ),
      title: Text(
        item.label,
        style: theme.typography.bodyMedium.copyWith(
          color: item.isSelected ? theme.colors.primary : theme.colors.onSurfaceVariant,
          fontWeight: item.isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      selected: item.isSelected,
      selectedTileColor: theme.colors.primary.withValues(alpha: 0.05),
      onTap: () {
        context.go(item.route);
      },
    );
  }

}
