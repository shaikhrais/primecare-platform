// Governance - Category: middleware | Purpose: UPGRADED_BY_AI Automatically querying the synced Prisma models const data = await prisma.compliancemanagerriskregiste...
// UPGRADED_BY_AI
import 'dart:convert';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';

part 'src/features/compliance_manager_risk_register_screen_routes/compliance_manager_risk_register_screen_routes.dart';

class ApiRoutes extends BaseModularApiRoutes {
  final prisma = PrismaClient();


  @override
  Iterable<BaseApiRoutes> get modules => [
    ComplianceManagerRiskRegisterScreenRoutes(prisma),
  ];
}
