import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

/// [Layout] - The master shell for all PrimeCare Dashboards.
/// Provides a consistent structural foundation with automatic padding and
/// background styling.
class MasterLayout extends ConsumerWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final AppShellType? shellType;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;

  const MasterLayout({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.shellType,
    this.drawer,
    this.endDrawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final authState = ref.watch(authProvider);
    final app = ref.watch(platformApplicationProvider);
    final tenant = app.tenant;
    final connectivityState = ref.watch(connectivityProvider);
    final isOffline = connectivityState.value == false;

    return Scaffold(
      backgroundColor: theme.colors.background,
      drawer: drawer ?? _buildSidebar(context, authState, tenant),
      endDrawer: endDrawer,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              LucideIcons.shieldCheck,
              color: tenant.branding.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tenant.name,
                  style: theme.typography.h3.copyWith(
                    color: tenant.branding.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getDefaultTitle(shellType),
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colors.primary.withValues(alpha: 0.1),
                border: Border.all(
                  color: theme.colors.primary.withValues(alpha: 0.3),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                app.name.toUpperCase(),
                style: theme.typography.labelBold.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: theme.colors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: actions ?? _getDefaultActions(context, authState),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(LucideIcons.menu, color: theme.colors.primary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: theme.colors.divider, height: 1),
        ),
      ),
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Column(
          children: [
            if (isOffline)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: theme.colors.error.withValues(alpha: 0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.wifiOff, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Offline Mode - Viewing cached data. Changes will sync when reconnected.',
                      style: theme.typography.labelBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: AppShellBoundary(child: OmniConstraintWrapper(child: child)),
            ),
          ],
        ),
      ),
    );
  }

  String _getDefaultTitle(AppShellType? type) {
    switch (type) {
      case AppShellType.provider:
        return 'Provider Operations';
      case AppShellType.clinical:
        return 'Clinical Intelligence';
      case AppShellType.admin:
        return 'Platform Governance';
      case AppShellType.system:
        return 'System Integrity';
      case AppShellType.patient:
        return 'Care Portal';
      default:
        return 'PrimeCare';
    }
  }

  List<Widget> _getDefaultActions(BuildContext context, AuthState auth) {
    final theme = context.theme;
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(LucideIcons.search, color: theme.colors.onSurfaceVariant),
      ),
      PopupMenuButton<String>(
        offset: const Offset(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.colors.border),
        ),
        tooltip: 'User Functions',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
            backgroundImage: NetworkImage(
              'https://api.dicebear.com/7.x/avataaars/png?seed=${auth.userName ?? 'User'}',
            ),
          ),
        ),
        onSelected: (value) {
          if (value == 'logout') {
            ProviderScope.containerOf(context).read(authProvider.notifier).logout();
          } else if (value == 'profile') {
            // Future: Navigate to profile
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  auth.userName ?? 'System User',
                  style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  auth.role ?? 'Guest',
                  style: theme.typography.labelSmall.copyWith(color: theme.colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'profile',
            child: Row(
              children: [
                Icon(LucideIcons.user, size: 18, color: theme.colors.onSurfaceVariant),
                const SizedBox(width: 12),
                Text('User Profile', style: theme.typography.bodyMedium),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'settings',
            child: Row(
              children: [
                Icon(LucideIcons.settings, size: 18, color: theme.colors.onSurfaceVariant),
                const SizedBox(width: 12),
                Text('Account Settings', style: theme.typography.bodyMedium),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'logout',
            child: Row(
              children: [
                Icon(LucideIcons.logOut, size: 18, color: theme.colors.error),
                const SizedBox(width: 12),
                Text('Sign Out', style: theme.typography.bodyMedium.copyWith(color: theme.colors.error)),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(width: 8),
    ];
  }

  Widget? _buildSidebar(
    BuildContext context,
    AuthState auth,
    PlatformTenant tenant,
  ) {
    final activeRole = PlatformRole.fromName(auth.role);
    final govRole = GovernanceRole(activeRole);

    // Fetch the current route from GoRouter
    String currentRoute = '';
    try {
      currentRoute = GoRouterState.of(context).uri.toString();
    } catch (_) {}

    // Prioritize registry-driven menu items for "Real Programmer" consistency
    final List<PrimeCareNavigationItem> items = govRole.menuItems;

    return PrimeCareSidebar(
      userName: auth.userName ?? 'System User',
      userRole: govRole.name,
      currentRoute: currentRoute,
      items: items,
      tenantName: tenant.name,
      tenantColor: tenant.branding.primaryColor,
    );
  }
}

/// [Alias] - Redirects legacy ProviderLayout calls to MasterLayout.
class ProviderLayout extends MasterLayout {
  const ProviderLayout({
    super.key,
    required super.child,
    super.title,
    super.actions,
  });
}
