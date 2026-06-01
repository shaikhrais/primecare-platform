// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE The central Governance Layout for all PrimeCare portals. It automatically pulls sidebar and ...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../models/domain_governance.dart';
import '../../models/screen.dart';
import '../../models/governance_role.dart';
import '../platform_role.dart';
import '../../aura_behavioral_telemetry.dart';
import '../../auth_service.dart';
import '../../security/shortcuts/index.dart';
import '../../config/screen_breakpoints.dart';
import '../../config/adaptive_scaling_config.dart';

import 'package:lucide_icons/lucide_icons.dart';
import 'dart:ui';
import '../role_registry.dart';
import '../../src/localization/language_provider.dart';

/// The central Governance Layout for all PrimeCare portals.
/// It automatically pulls sidebar and top-bar data from the [PlatformApplication]
/// based on the [activeRole], ensuring layout consistency and "Zero-Trust" routing paths.
class GovernanceMasterLayout extends ConsumerWidget {
  final PlatformApplication application;
  final PlatformRole activeRole;
  final Widget child;

  const GovernanceMasterLayout({
    super.key,
    required this.application,
    required this.activeRole,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modules = application.getAuthorizedModules(activeRole);
    final tenant = application.tenant;
    final tier = ScreenBreakpoints.getTier(MediaQuery.of(context).size.width);
    final isHandheld = ScreenBreakpoints.isHandheld(context);

    // Sync Governance Context to Telemetry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(auraBehavioralTelemetryProvider)
          .updateGovernanceContext(tenant: tenant, role: activeRole);
    });

    final theme = Theme.of(context);

    return Theme(
      data: tenant.branding,
      child: QuickAccessBoundary(
        userRole: GovernanceRole(activeRole),
        currentOffice: 'CORPORATE', // Or retrieve this dynamically
        child: Semantics(
          label: 'data-cy:app-shell',
          container: true,
          child: KeyedSubtree(
            key: const Key('app-shell'),
            child: Scaffold(
          drawer: isHandheld ? _buildSidebar(context, ref, theme, modules, tenant, tier) : null,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Semantics(
              label: 'data-cy:app-topbar',
              container: true,
              child: KeyedSubtree(
                key: const Key('app-topbar'),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  surfaceTintColor: Colors.transparent,
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(LucideIcons.shieldCheck, color: theme.primaryColor),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tenant.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            application.name,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    // HUD: Role & Metrics (Clickable Role Switcher)
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierColor: Colors.black.withValues(alpha: 0.5),
                          builder: (context) => _RoleSwitcherDialog(
                            activeRole: activeRole,
                            ref: ref,
                          ),
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(LucideIcons.user, size: 14, color: theme.primaryColor),
                              const SizedBox(width: 8),
                              Text(
                                activeRole.displayName,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(LucideIcons.chevronDown, size: 12, color: theme.primaryColor),
                              const SizedBox(width: 12),
                              Container(
                                width: 1,
                                height: 14,
                                color: theme.primaryColor.withValues(alpha: 0.2),
                              ),
                              const SizedBox(width: 12),
                              Builder(
                                builder: (context) {
                                  final govRole = GovernanceRole(activeRole);
                                  return Row(
                                    children: [
                                      Icon(LucideIcons.layers, size: 14, color: theme.primaryColor.withValues(alpha: 0.7)),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Role Items: ${govRole.totalSidebarItems}',
                                        style: theme.textTheme.labelSmall?.copyWith(
                                          color: theme.primaryColor.withValues(alpha: 0.8),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(LucideIcons.appWindow, size: 14, color: theme.primaryColor.withValues(alpha: 0.7)),
                                      const SizedBox(width: 4),
                                      Text(
                                        'App Total: ${govRole.totalAppSidebarItems}',
                                        style: theme.textTheme.labelSmall?.copyWith(
                                          color: theme.primaryColor.withValues(alpha: 0.8),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Semantics(
                      label: 'data-cy:topbar-language-switcher',
                      container: true,
                      child: KeyedSubtree(
                        key: const Key('topbar-language-switcher'),
                        child: PopupMenuButton<String>(
                          offset: const Offset(0, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: theme.dividerColor),
                          ),
                          tooltip: 'Change Language',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(LucideIcons.languages, color: theme.primaryColor, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  ref.watch(languageProvider).toUpperCase(),
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
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
                              child: Semantics(
                                label: 'data-cy:topbar-language-option-en',
                                container: false,
                                child: KeyedSubtree(
                                  key: const Key('topbar-language-option-en'),
                                  child: Text('English (EN)', style: theme.textTheme.bodyMedium),
                                ),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'fr',
                              child: Semantics(
                                label: 'data-cy:topbar-language-option-fr',
                                container: false,
                                child: KeyedSubtree(
                                  key: const Key('topbar-language-option-fr'),
                                  child: Text('Français (FR)', style: theme.textTheme.bodyMedium),
                                ),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'es',
                              child: Semantics(
                                label: 'data-cy:topbar-language-option-es',
                                container: false,
                                child: KeyedSubtree(
                                  key: const Key('topbar-language-option-es'),
                                  child: Text('Español (ES)', style: theme.textTheme.bodyMedium),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(LucideIcons.logOut),
                      onPressed: () {
                        ref.read(authProvider.notifier).logout();
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),
        body: Row(
          children: [
            // Premium Governance Sidebar
            if (!isHandheld)
              _buildSidebar(context, ref, theme, modules, tenant, tier),
            // Main Content Area
            Expanded(
              child: Semantics(
                label: 'data-cy:app-content-slot',
                container: true,
                child: KeyedSubtree(
                  key: const Key('app-content-slot'),
                  child: Container(
                    color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                    child: AppShellBoundary(child: child),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, WidgetRef ref, ThemeData theme, List<PlatformModule> modules, PlatformTenant tenant, ResolutionTier tier) {
    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Semantics(
        label: 'data-cy:app-sidebar',
        container: true,
        child: KeyedSubtree(
          key: const Key('app-sidebar'),
          child: Container(
            width: AdaptiveScalingConfig.getSidebarWidth(tier),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(
            right: BorderSide(
              color: theme.dividerColor.withValues(alpha: 0.05),
            ),
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final module = modules[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        module.icon,
                        size: 18,
                        color: theme.primaryColor.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        module.name.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ...module.screens
                    .where((screen) =>
                        screen.requiredRole == null ||
                        screen.requiredRole == activeRole)
                    .map((screen) {
                  
                  String currentRoute = '';
                  try {
                    currentRoute = GoRouterState.of(context).uri.toString();
                  } catch (_) {
                    currentRoute = '';
                  }
                  
                  final isSelected = currentRoute == screen.route;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: ListTile(
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selected: isSelected,
                      selectedTileColor: theme.primaryColor.withValues(alpha: 0.05),
                      leading: Icon(
                        screen.icon ?? LucideIcons.circle,
                        size: 18,
                        color: isSelected ? theme.primaryColor : theme.iconTheme.color?.withValues(alpha: 0.6),
                      ),
                      title: Text(
                        screen.title,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? theme.primaryColor : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      onTap: () {
                        ref
                            .read(auraBehavioralTelemetryProvider)
                            .updateGovernanceContext(
                              tenant: tenant,
                              role: activeRole,
                              module: module,
                            );

                        if (ScreenBreakpoints.isHandheld(context)) {
                          Navigator.of(context).pop();
                        }

                        if (screen.requiredRole == null ||
                            screen.requiredRole == activeRole) {
                          context.go(screen.route);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                tr('governance.unauthorized_access'),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
        ),
        ),
      ),
    );
  }
}

class _RoleSwitcherDialog extends StatefulWidget {
  final PlatformRole activeRole;
  final WidgetRef ref;

  const _RoleSwitcherDialog({
    required this.activeRole,
    required this.ref,
  });

  @override
  State<_RoleSwitcherDialog> createState() => _RoleSwitcherDialogState();
}

class _RoleSwitcherDialogState extends State<_RoleSwitcherDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allRoles = RoleRegistry.getAllRoles();

    // Filter roles
    final filteredRoles = allRoles.where((metadata) {
      final query = _searchQuery.toLowerCase();
      final displayName = metadata.role.displayName.toLowerCase();
      final category = metadata.category.toLowerCase();
      final portal = metadata.defaultPortal.toLowerCase();
      final access = metadata.accessLevel.toLowerCase();
      return displayName.contains(query) ||
          category.contains(query) ||
          portal.contains(query) ||
          access.contains(query);
    }).toList();

    // Group by category
    final Map<String, List<RoleMetadata>> grouped = {};
    for (final roleMeta in filteredRoles) {
      grouped.putIfAbsent(roleMeta.category, () => []).add(roleMeta);
    }

    // Sort categories alphabetically
    final sortedCategories = grouped.keys.toList()..sort();

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          width: 580,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.primaryColor.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        LucideIcons.shieldAlert,
                        color: theme.primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cross-Role Intelligence Switcher',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Select a simulated active role to update navigation topology',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.x, size: 18),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search roles by name, category, or portal...',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                    ),
                    prefixIcon: Icon(
                      LucideIcons.search,
                      size: 16,
                      color: theme.primaryColor.withValues(alpha: 0.7),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = "";
                              });
                            },
                            child: Icon(
                              LucideIcons.xCircle,
                              size: 16,
                              color: theme.primaryColor.withValues(alpha: 0.7),
                            ),
                          )
                        : null,
                    filled: true,
                    fillColor: theme.primaryColor.withValues(alpha: 0.03),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: theme.primaryColor.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Roles List
              Expanded(
                child: filteredRoles.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.searchCode,
                              size: 40,
                              color: theme.primaryColor.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No matching roles found',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        itemCount: sortedCategories.length,
                        itemBuilder: (context, index) {
                          final category = sortedCategories[index];
                          final categoryRoles = grouped[category]!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  category.toUpperCase(),
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              ...categoryRoles.map((roleMeta) {
                                final isSelected = roleMeta.role == widget.activeRole;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _RoleTile(
                                    roleMeta: roleMeta,
                                    isSelected: isSelected,
                                    onTap: () {
                                      // 1. Simulate Session
                                      widget.ref.read(authProvider.notifier)
                                          .simulateRoleSession(roleMeta.role.nameSnake);
                                      // 2. Resolve destination route
                                      final route = AuthNotifier.getDashboardRouteForRole(roleMeta.role.nameSnake);
                                      // 3. Close switcher dialog
                                      Navigator.of(context).pop();
                                      // 4. Navigate
                                      context.go(route);
                                    },
                                  ),
                                );
                              }),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
              ),

              // Bottom HUD indicator showing count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Mapped: ${allRoles.length} Roles',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.textTheme.labelSmall?.color?.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      'Filtered: ${filteredRoles.length}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
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
}

class _RoleTile extends StatefulWidget {
  final RoleMetadata roleMeta;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleTile({
    required this.roleMeta,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_RoleTile> createState() => _RoleTileState();
}

class _RoleTileState extends State<_RoleTile> {
  bool _isHovered = false;

  Color _getAccessColor(String accessLevel) {
    switch (accessLevel.toLowerCase()) {
      case 'admin':
        return Colors.redAccent;
      case 'compliance':
        return Colors.purpleAccent;
      case 'write':
        return Colors.blueAccent;
      case 'read':
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accessColor = _getAccessColor(widget.roleMeta.accessLevel);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? theme.primaryColor.withValues(alpha: 0.08)
                : (_isHovered
                    ? theme.primaryColor.withValues(alpha: 0.03)
                    : theme.cardColor),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.isSelected
                  ? theme.primaryColor
                  : (_isHovered
                      ? theme.primaryColor.withValues(alpha: 0.3)
                      : theme.primaryColor.withValues(alpha: 0.06)),
              width: widget.isSelected ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Icon Badge with beautiful layout
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.isSelected
                      ? theme.primaryColor.withValues(alpha: 0.1)
                      : theme.primaryColor.withValues(alpha: 0.04),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.isSelected ? LucideIcons.checkCircle2 : LucideIcons.shield,
                  color: widget.isSelected ? theme.primaryColor : theme.primaryColor.withValues(alpha: 0.7),
                  size: 16,
                ),
              ),
              const SizedBox(width: 14),

              // Title and portal info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.roleMeta.role.displayName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w600,
                        color: widget.isSelected ? theme.primaryColor : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.globe,
                          size: 10,
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.roleMeta.defaultPortal,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Access badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accessColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accessColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  widget.roleMeta.accessLevel.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: accessColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
