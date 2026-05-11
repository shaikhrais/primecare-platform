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

    return Scaffold(
      backgroundColor: theme.colors.background,
      drawer: drawer ?? _buildSidebar(context, authState),
      endDrawer: endDrawer,
      appBar: AppBar(
        title: Text(
          title ?? _getDefaultTitle(shellType),
          style: theme.typography.h3.copyWith(color: theme.colors.primary),
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

  Widget? _buildSidebar(BuildContext context, AuthState auth) {
    final activeRole = PlatformRole.fromName(auth.role);
    final govRole = GovernanceRole(activeRole);
    
    // Fetch the current route from GoRouter
    final currentRoute = GoRouterState.of(context).uri.toString();

    // Prioritize registry-driven menu items for "Real Programmer" consistency
    final List<PrimeCareNavigationItem> items = govRole.menuItems;

    return PrimeCareSidebar(
      userName: auth.userName ?? 'System User',
      userRole: govRole.name,
      currentRoute: currentRoute,
      items: items,
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
