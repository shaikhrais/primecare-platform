// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../models/domain_governance.dart';
import '../../models/screen.dart';
import '../platform_role.dart';
import '../../aura_behavioral_telemetry.dart';

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

    return Theme(
      data: tenant.branding,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${tenant.name} - ${application.name}'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  tr('governance.role_label', args: [activeRole.displayName]),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            // Governance Sidebar
            SizedBox(
              width: 250,
              child: ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  final module = modules[index];
                  return ExpansionTile(
                    leading: Icon(module.icon),
                    title: Text(module.name),
                    initiallyExpanded: true,
                    onExpansionChanged: (expanded) {
                      if (expanded) {
                        ref
                            .read(auraBehavioralTelemetryProvider)
                            .updateGovernanceContext(
                              tenant: tenant,
                              role: activeRole,
                              module: module,
                            );
                      }
                    },
                    children: module.screens.map((screen) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 48.0,
                          right: 16.0,
                        ),
                        title: Text(screen.title),
                        subtitle: screen.subtitle.isNotEmpty
                            ? Text(screen.subtitle)
                            : null,
                        onTap: () {
                          // Update telemetry context on navigation attempt
                          ref
                              .read(auraBehavioralTelemetryProvider)
                              .updateGovernanceContext(
                                tenant: tenant,
                                role: activeRole,
                                module: module,
                              );

                          // Zero-trust routing: Only allow navigation to authorized screen routes
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
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1, thickness: 1),
            // Main Content Area with Governance Layout Invariant Enforcement
            Expanded(child: AppShellBoundary(child: child)),
          ],
        ),
      ),
    );
  }
}
