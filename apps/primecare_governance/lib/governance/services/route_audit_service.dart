import 'package:flutter_core/flutter_core.dart';

class RouteAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (!s.routePath.startsWith('/')) {
      issues.add(
        PlatformAuditIssue(
          id: 'route_invalid_${s.id}',
          title: 'Invalid Route Path',
          category: GovernanceCategory.routing,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Routing',
          issue: 'Invalid route path: ${s.routePath}',
          suggestion: 'Route path must start with a forward slash (/).',
          severity: AuditSeverity.critical,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    if (s.routePath.length > 1 && s.routePath.endsWith('/')) {
      issues.add(
        PlatformAuditIssue(
          id: 'route_trailing_${s.id}',
          title: 'Trailing Slash in Route',
          category: GovernanceCategory.routing,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Routing',
          issue: 'Trailing slash in route path.',
          suggestion: 'Remove the trailing slash for consistency.',
          severity: AuditSeverity.low,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    return issues;
  }
}
