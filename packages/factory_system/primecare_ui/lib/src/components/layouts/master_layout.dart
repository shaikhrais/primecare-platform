import 'package:primecare_ui/primecare_ui.dart';

/// [Layout] - The master shell for all PrimeCare Dashboards.
/// Provides a consistent structural foundation with automatic padding and 
/// background styling.
class MasterLayout extends ConsumerWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final AppShellType? shellType;
  final Widget? drawer;
  final Widget? floatingActionButton;

  const MasterLayout({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.shellType,
    this.drawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      drawer: drawer ?? _buildSidebar(context, authState),
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
        child: child,
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

  List<Widget> _getDefaultActions(BuildContext context, dynamic authState) {
    final theme = context.theme;
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(LucideIcons.search, color: theme.colors.onSurfaceVariant),
      ),
      const CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage('https://api.dicebear.com/7.x/avataaars/png?seed=User'),
      ),
      const SizedBox(width: 16),
    ];
  }

  Widget? _buildSidebar(BuildContext context, dynamic auth) {
    if (shellType == null) return null;

    return PrimeCareSidebar(
      userName: auth.user?.name ?? 'Alex Rivera',
      userRole: auth.role ?? 'Senior Administrator',
      items: _getNavigationItems(shellType!),
    );
  }

  List<NavigationItem> _getNavigationItems(AppShellType type) {
    switch (type) {
      case AppShellType.provider:
        return [
          const NavigationItem(icon: LucideIcons.layoutDashboard, label: 'Dashboard', route: ClinicalRoutes.pswDashboard, isSelected: true),
          const NavigationItem(icon: LucideIcons.users, label: 'Clients', route: '/psw/clients'),
          const NavigationItem(icon: LucideIcons.listTodo, label: 'Tasks', route: '/psw/tasks'),
          const NavigationItem(icon: LucideIcons.calendar, label: 'Schedule', route: '/psw/schedule'),
          const NavigationItem(icon: LucideIcons.messageSquare, label: 'Messages', route: '/psw/messages'),
        ];
      case AppShellType.clinical:
        return [
          const NavigationItem(icon: LucideIcons.activity, label: 'Clinical Ops', route: CommonRoutes.clinicDashboard, isSelected: true),
          const NavigationItem(icon: LucideIcons.userPlus, label: 'Intake', route: '/clinic/intake'),
          const NavigationItem(icon: LucideIcons.fileText, label: 'Care Plans', route: CommonRoutes.clinicCarePlan),
          const NavigationItem(icon: LucideIcons.history, label: 'History', route: CommonRoutes.clinicHistoryLogs),
        ];
      default:
        return [];
    }
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
