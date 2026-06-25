// Governance - Category: view | Purpose: [Layout] - The master shell for all PrimeCare Dashboards. Provides a consistent structural foundation with automatic padding and background styling.
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

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
    final zoomFactor = ref.watch(contentZoomProvider);

    final isHandheld = ScreenBreakpoints.isHandheld(context);
    final sidebarWidget = drawer ?? _buildSidebar(context, authState, tenant);

    return Cy(
      id: 'app-shell',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        drawer: isHandheld ? sidebarWidget : null,
        endDrawer: endDrawer,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Cy(
            id: 'app-topbar',
            child: AppBar(
              title: Row(
                children: [
                  Icon(
                    LucideIcons.shieldCheck,
                    color: theme.colors.topbarSelectedTextColor,
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
                          color: theme.colors.topbarSelectedTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getDefaultTitle(shellType).tr(),
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.topbarTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colors.topbarSelectedTextColor.withValues(alpha: 0.15),
                      border: Border.all(
                        color: theme.colors.topbarSelectedTextColor.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      app.name.toUpperCase(),
                      style: theme.typography.labelBold.copyWith(
                        color: theme.colors.topbarSelectedTextColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: theme.colors.topbarBackground,
              elevation: 0,
              scrolledUnderElevation: 0,
              actions: actions ?? _getDefaultActions(context, ref, authState, zoomFactor),
              leading: isHandheld
                  ? Builder(
                      builder: (context) => IconButton(
                        key: const Key('master_layout_iconbutton_button_1'),
                        icon: Icon(LucideIcons.menu, color: theme.colors.topbarSelectedIconColor),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    )
                  : null,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(color: theme.colors.topbarDividerColor, height: 1),
              ),
            ),
          ),
        ),
        floatingActionButton: floatingActionButton,
        body: SafeArea(
          child: Row(
            children: [
              if (!isHandheld && sidebarWidget != null) sidebarWidget,
              Expanded(
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
                              'Offline Mode - Viewing cached data. Changes will sync when reconnected.'.tr(),
                              style: theme.typography.labelBold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Cy(
                        id: 'app-content-slot',
                        child: AppShellBoundary(child: OmniConstraintWrapper(child: child)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  List<Widget> _getDefaultActions(
    BuildContext context,
    WidgetRef ref,
    AuthState auth,
    double zoomFactor,
  ) {
    final theme = context.theme;
    return [
      if (kIsWeb)
        IconButton(
          key: const Key('topbar-app-hub-button'),
          tooltip: 'App Hub'.tr(),
          icon: Icon(
            LucideIcons.home,
            color: theme.colors.topbarSelectedIconColor,
            size: 20,
          ),
          onPressed: () {
            launchUrl(
              Uri.parse('https://primecare-auth.pages.dev/success'),
              mode: LaunchMode.platformDefault,
            );
          },
        ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(key: const Key('master_layout_iconbutton_button_2'), 
            tooltip: 'Zoom Out'.tr(),
            onPressed: () {
              ref.read(contentZoomProvider.notifier).zoomOut();
            },
            icon: Icon(
              LucideIcons.zoomOut,
              color: theme.colors.topbarTextColor,
              size: 20,
            ),
          ),
          Tooltip(
            message: 'Reset Zoom (Double tap)'.tr(),
            child: GestureDetector(
              onDoubleTap: () {
                ref.read(contentZoomProvider.notifier).resetZoom();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colors.topbarSelectedTextColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colors.topbarSelectedTextColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${(zoomFactor * 100).toInt()}%',
                  style: theme.typography.labelBold.copyWith(
                    color: theme.colors.topbarSelectedTextColor,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          IconButton(key: const Key('master_layout_iconbutton_button_3'), 
            tooltip: 'Zoom In'.tr(),
            onPressed: () {
              ref.read(contentZoomProvider.notifier).zoomIn();
            },
            icon: Icon(
              LucideIcons.zoomIn,
              color: theme.colors.topbarTextColor,
              size: 20,
            ),
          ),
        ],
      ),
      const SizedBox(width: 8),
      Cy(
        id: 'topbar-language-switcher',
        child: PopupMenuButton<String>(
          key: const Key('topbar-language-switcher'),
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: theme.colors.topbarDividerColor),
          ),
          color: theme.colors.topbarBackground,
          tooltip: 'Change Language'.tr(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.languages, color: theme.colors.topbarTextColor, size: 20),
                const SizedBox(width: 6),
                Text(
                  ref.watch(languageProvider).toUpperCase(),
                  style: theme.typography.labelBold.copyWith(
                    color: theme.colors.topbarSelectedTextColor,
                    fontSize: 13,
                  ),
                ),
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
              child: Cy(
                id: 'topbar-language-option-en',
                container: false,
                child: Text('English (EN)', style: theme.typography.bodyMedium.copyWith(color: theme.colors.topbarTextColor)),
              ),
            ),
            PopupMenuItem<String>(
              value: 'fr',
              child: Cy(
                id: 'topbar-language-option-fr',
                container: false,
                child: Text('Français (FR)', style: theme.typography.bodyMedium.copyWith(color: theme.colors.topbarTextColor)),
              ),
            ),
            PopupMenuItem<String>(
              value: 'es',
              child: Cy(
                id: 'topbar-language-option-es',
                container: false,
                child: Text('Español (ES)', style: theme.typography.bodyMedium.copyWith(color: theme.colors.topbarTextColor)),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      IconButton(key: const Key('master_layout_iconbutton_button_4'), 
        onPressed: () {},
        icon: Icon(LucideIcons.search, color: theme.colors.topbarTextColor),
      ),
      Cy(
        id: 'topbar-user-menu',
        child: PopupMenuButton<String>(
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: theme.colors.topbarDividerColor),
          ),
          color: theme.colors.topbarBackground,
          tooltip: 'User Functions',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: theme.colors.topbarSelectedTextColor.withValues(alpha: 0.1),
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
                    style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: theme.colors.topbarSelectedTextColor),
                  ),
                  Text(
                    auth.role ?? 'Guest',
                    style: theme.typography.labelSmall.copyWith(color: theme.colors.topbarTextColor),
                  ),
                ],
              ),
            ),
            PopupMenuDivider(color: theme.colors.topbarDividerColor),
            PopupMenuItem<String>(
              value: 'profile',
              child: Row(
                children: [
                  Icon(LucideIcons.user, size: 18, color: theme.colors.topbarTextColor),
                  const SizedBox(width: 12),
                  Text('User Profile'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.topbarTextColor)),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'settings',
              child: Row(
                children: [
                  Icon(LucideIcons.settings, size: 18, color: theme.colors.topbarTextColor),
                  const SizedBox(width: 12),
                  Text('Account Settings'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.topbarTextColor)),
                ],
              ),
            ),
            PopupMenuDivider(color: theme.colors.topbarDividerColor),
            PopupMenuItem<String>(
              value: 'logout',
              child: Cy(
                id: 'topbar-logout-button',
                container: false,
                child: Row(
                  children: [
                    Icon(LucideIcons.logOut, size: 18, color: theme.colors.error),
                    const SizedBox(width: 12),
                    Text('Sign Out'.tr(), style: theme.typography.bodyMedium.copyWith(color: theme.colors.error)),
                  ],
                ),
              ),
            ),
          ],
        ),
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

    return Cy(
      id: 'app-sidebar',
      child: PrimeCareSidebar(
        userName: auth.userName ?? 'System User',
        userRole: govRole.name,
        currentRoute: currentRoute,
        items: items,
        tenantName: tenant.name,
        tenantColor: tenant.branding.primaryColor,
      ),
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
