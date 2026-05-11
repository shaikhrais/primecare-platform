// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../models/domain_governance.dart';
import '../../models/screen.dart';
import '../platform_role.dart';
import '../../aura_behavioral_telemetry.dart';
import '../../auth_service.dart';

import 'package:lucide_icons/lucide_icons.dart';

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

    // Sync Governance Context to Telemetry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(auraBehavioralTelemetryProvider)
          .updateGovernanceContext(tenant: tenant, role: activeRole);
    });

    final theme = Theme.of(context);

    return Theme(
      data: tenant.branding,
      child: Scaffold(
        appBar: AppBar(
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
            Container(
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
                ],
              ),
            ),
            IconButton(
              icon: const Icon(LucideIcons.logOut),
              onPressed: () {
                ref.read(authProvider.notifier).logout();
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Row(
          children: [
            // Premium Governance Sidebar
            Container(
              width: 280,
              decoration: BoxDecoration(
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
                        final isSelected = GoRouterState.of(context).uri.toString() == screen.route;
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
            // Main Content Area
            Expanded(
              child: Container(
                color: theme.scaffoldBackgroundColor.withValues(alpha: 0.5),
                child: AppShellBoundary(child: child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
