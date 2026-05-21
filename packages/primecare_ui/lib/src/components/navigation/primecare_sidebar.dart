import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class PrimeCareSidebar extends StatelessWidget {
  final String userName;
  final String userRole;
  final String? userAvatarUrl;
  final List<PrimeCareNavigationItem> items;
  final String? currentRoute;
  final Widget? footer;
  final String? tenantName;
  final Color? tenantColor;

  const PrimeCareSidebar({
    super.key,
    required this.userName,
    required this.userRole,
    this.userAvatarUrl,
    required this.items,
    this.currentRoute,
    this.footer,
    this.tenantName,
    this.tenantColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Drawer(
      backgroundColor: theme.colors.surface,
      width: context.s(320), // Responsive sidebar width
      child: Column(
        children: [
          _buildTenantHeader(context, theme),
          SizedBox(height: context.s(24)),
          _buildProfileSection(context, theme),
          Divider(color: theme.colors.divider),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: context.s(12)),
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return _buildNexusTriggerItem(context);
                }
                final item = items[index];
                return _buildNavItem(context, item);
              },
            ),
          ),
          if (footer != null) footer!,
          SizedBox(height: context.s(24)),
        ],
      ),
    );
  }

  Widget _buildNexusTriggerItem(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.only(top: context.s(12), bottom: context.s(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.s(12)),
          gradient: LinearGradient(
            colors: [
              theme.colors.primary.withValues(alpha: 0.15),
              theme.colors.primary.withValues(alpha: 0.03),
            ],
          ),
          border: Border.all(
            color: theme.colors.primary.withValues(alpha: 0.3),
            width: context.s(1),
          ),
        ),
        child: ListTile(
          leading: Icon(
            LucideIcons.pocket,
            size: context.s(20),
            color: theme.colors.primary,
          ),
          title: Text(
            'Aura Nexus Center',
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.primary,
              fontSize: context.s(14),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Global AI Chat & HUD Console',
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.onSurfaceVariant.withValues(alpha: 0.7),
              fontSize: context.s(11),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.s(12)),
          ),
          onTap: () {
            Navigator.of(context).pop(); // Close sidebar
            Scaffold.of(context).openEndDrawer(); // Open console
          },
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, PrimeThemeData theme) {
    return Padding(
      padding: EdgeInsets.all(context.s(24.0)),
      child: Column(
        children: [
          CircleAvatar(
            radius: context.s(40),
            backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
            backgroundImage: NetworkImage(
              userAvatarUrl ??
                  'https://api.dicebear.com/7.x/avataaars/png?seed=$userName',
            ),
          ),
          SizedBox(height: context.s(16)),
          Text(
            userName,
            style: theme.typography.h3.copyWith(fontSize: context.s(18)),
          ),
          Text(
            userRole,
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.onSurfaceVariant,
              fontSize: context.s(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, PrimeCareNavigationItem item) {
    final theme = context.theme;
    final isSelected =
        currentRoute == item.route ||
        ((currentRoute?.startsWith(item.route) ?? false) && item.route != '/');

    return ListTile(
      leading: Icon(
        item.icon,
        size: context.s(20),
        color: isSelected
            ? theme.colors.primary
            : theme.colors.onSurfaceVariant,
      ),
      title: Text(
        item.label,
        style: theme.typography.bodyMedium.copyWith(
          color: isSelected
              ? theme.colors.primary
              : theme.colors.onSurfaceVariant,
          fontSize: context.s(14),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.s(8)),
      ),
      selected: isSelected,
      selectedTileColor: theme.colors.primary.withValues(alpha: 0.05),
      onTap: () {
        context.go(item.route);
      },
    );
  }

  Widget _buildTenantHeader(BuildContext context, PrimeThemeData theme) {
    if (tenantName == null) return SizedBox(height: context.s(60));
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.s(24),
        context.s(60),
        context.s(24),
        context.s(16),
      ),
      color: (tenantColor ?? theme.colors.primary).withValues(alpha: 0.1),
      child: Row(
        children: [
          Icon(
            LucideIcons.shieldCheck,
            color: tenantColor ?? theme.colors.primary,
            size: context.s(28),
          ),
          SizedBox(width: context.s(12)),
          Expanded(
            child: Text(
              tenantName!,
              style: theme.typography.h3.copyWith(
                color: tenantColor ?? theme.colors.primary,
                fontSize: context.s(18),
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
