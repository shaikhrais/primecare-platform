// Governance - Category: middleware | Purpose: UPGRADED_BY_AI Automatically querying the synced Prisma models const data = await prisma.screengovernanceservice.find...
// UPGRADED_BY_AI
import 'dart:convert';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';

part 'src/features/screen_governance_service_routes/screen_governance_service_routes.dart';
part 'src/features/screen_governance_reporter_routes/screen_governance_reporter_routes.dart';
part 'src/features/governance_role_viewer_routes/governance_role_viewer_routes.dart';

class ApiRoutes extends BaseModularApiRoutes {
  final prisma = PrismaClient();


  @override
  Iterable<BaseApiRoutes> get modules => [
    ScreenGovernanceServiceRoutes(prisma),
    ScreenGovernanceReporterRoutes(prisma),
    GovernanceRoleViewerRoutes(prisma),
  ];
}
