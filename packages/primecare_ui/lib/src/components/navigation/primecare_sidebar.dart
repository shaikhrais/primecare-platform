// Governance - Category: view | Purpose: Core implementation file for the Primecare Sidebar platform logic.
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class PrimeCareSidebar extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    return Drawer(
      backgroundColor: theme.colors.sidebarBackground,
      width: context.s(320), // Responsive sidebar width
      child: Column(
        children: [
          _buildTenantHeader(context, theme),
          SizedBox(height: context.s(24)),
          _buildProfileSection(context, theme),
          Divider(color: theme.colors.sidebarDividerColor),
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
          _buildLanguageSwitcher(context, ref),
          if (footer != null) footer!,
          SizedBox(height: context.s(24)),
        ],
      ),
    );
  }

  Widget _buildLanguageSwitcher(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final currentLang = ref.watch(languageProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.s(12), vertical: context.s(8)),
      child: PopupMenuButton<String>(
        offset: const Offset(0, -140), // Pop up upwards since it's at the bottom
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.colors.sidebarDividerColor),
        ),
        color: theme.colors.sidebarBackground,
        tooltip: 'Change Language'.tr(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: context.s(16), vertical: context.s(12)),
          decoration: BoxDecoration(
            color: theme.colors.sidebarSelectedTileColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(context.s(8)),
          ),
          child: Row(
            children: [
              Icon(LucideIcons.languages, color: theme.colors.sidebarTextColor, size: context.s(20)),
              SizedBox(width: context.s(12)),
              Expanded(
                child: Text(
                  'Language'.tr(),
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.sidebarTextColor,
                    fontSize: context.s(14),
                  ),
                ),
              ),
              Text(
                currentLang.toUpperCase(),
                style: theme.typography.labelBold.copyWith(
                  color: theme.colors.sidebarSelectedTextColor,
                  fontSize: context.s(12),
                ),
              ),
              SizedBox(width: context.s(4)),
              Icon(LucideIcons.chevronUp, color: theme.colors.sidebarTextColor.withValues(alpha: 0.3), size: context.s(16)),
            ],
          ),
        ),
        onSelected: (lang) async {
          await ref.read(languageProvider.notifier).setLanguage(lang);
          if (context.mounted) {
            await context.setLocale(Locale(lang));
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'en',
            child: Text('English (EN)', style: theme.typography.bodyMedium.copyWith(color: theme.colors.sidebarTextColor)),
          ),
          PopupMenuItem<String>(
            value: 'fr',
            child: Text('Français (FR)', style: theme.typography.bodyMedium.copyWith(color: theme.colors.sidebarTextColor)),
          ),
          PopupMenuItem<String>(
            value: 'es',
            child: Text('Español (ES)', style: theme.typography.bodyMedium.copyWith(color: theme.colors.sidebarTextColor)),
          ),
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
              theme.colors.sidebarSelectedTileColor.withValues(alpha: 0.5),
              theme.colors.sidebarSelectedTileColor.withValues(alpha: 0.1),
            ],
          ),
          border: Border.all(
            color: theme.colors.sidebarDividerColor,
            width: context.s(1),
          ),
        ),
        child: ListTile(
          leading: Icon(
            LucideIcons.terminal,
            size: context.s(20),
            color: theme.colors.sidebarSelectedTextColor,
          ),
          title: Text(
            'Aura Nexus Center'.tr(),
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.sidebarSelectedTextColor,
              fontSize: context.s(14),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Global AI Chat & HUD Console'.tr(),
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.sidebarTextColor.withValues(alpha: 0.6),
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
            backgroundColor: theme.colors.sidebarSelectedTileColor,
            backgroundImage: NetworkImage(
              userAvatarUrl ??
                  'https://api.dicebear.com/7.x/avataaars/png?seed=$userName',
            ),
          ),
          SizedBox(height: context.s(16)),
          Text(
            userName,
            style: theme.typography.h3.copyWith(
              fontSize: context.s(18),
              color: theme.colors.sidebarSelectedTextColor,
            ),
          ),
          Text(
            userRole.tr(),
            style: theme.typography.bodySmall.copyWith(
              color: theme.colors.sidebarTextColor,
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

    return Cy(
      id: 'sidebar-nav-${item.label.toLowerCase().replaceAll(' ', '-')}',
      child: ListTile(
        leading: Icon(
          item.icon,
          size: context.s(20),
          color: isSelected
              ? theme.colors.sidebarSelectedIconColor
              : theme.colors.sidebarIconColor,
        ),
        title: Text(
          item.label.tr(),
          style: theme.typography.bodyMedium.copyWith(
            color: isSelected
                ? theme.colors.sidebarSelectedTextColor
                : theme.colors.sidebarTextColor,
            fontSize: context.s(14),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.s(8)),
        ),
        selected: isSelected,
        selectedTileColor: theme.colors.sidebarSelectedTileColor,
        onTap: () {
          context.go(item.route);
        },
      ),
    );
  }

  Widget _buildTenantHeader(BuildContext context, PrimeThemeData theme) {
    if (tenantName == null) return SizedBox(height: context.s(60));
    final headerColor = theme.colors.sidebarSelectedTextColor;
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.s(24),
        context.s(60),
        context.s(24),
        context.s(16),
      ),
      color: theme.colors.sidebarSelectedTileColor.withValues(alpha: 0.1),
      child: Row(
        children: [
          Icon(
            LucideIcons.shieldCheck,
            color: tenantColor ?? headerColor,
            size: context.s(28),
          ),
          SizedBox(width: context.s(12)),
          Expanded(
            child: Text(
              tenantName!,
              style: theme.typography.h3.copyWith(
                color: headerColor,
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
