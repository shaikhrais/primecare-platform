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
        child: AppShellBoundary(child: OmniConstraintWrapper(child: child)),
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
      const CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(
          'https://api.dicebear.com/7.x/avataaars/png?seed=User',
        ),
      ),
      const SizedBox(width: 16),
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
