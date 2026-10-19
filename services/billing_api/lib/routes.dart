// Governance - Category: middleware | Purpose: UPGRADED_BY_AI Automatically querying the synced Prisma models const data = await prisma.clientpaymentsscreen.findMan...
// UPGRADED_BY_AI
import 'dart:convert';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';

part 'src/features/client_payments_screen_routes/client_payments_screen_routes.dart';
part 'src/features/family_member_billing_screen_routes/family_member_billing_screen_routes.dart';
part 'src/features/cfo_invoices_screen_routes/cfo_invoices_screen_routes.dart';
part 'src/features/admin_invoices_screen_routes/admin_invoices_screen_routes.dart';
part 'src/features/admin_payments_screen_routes/admin_payments_screen_routes.dart';
part 'src/features/billing_admin_dashboard_screen_routes/billing_admin_dashboard_screen_routes.dart';
part 'src/features/billing_admin_invoices_screen_routes/billing_admin_invoices_screen_routes.dart';

class ApiRoutes extends BaseModularApiRoutes {
  final prisma = PrismaClient();


  @override
  Iterable<BaseApiRoutes> get modules => [
    ClientPaymentsScreenRoutes(prisma),
    FamilyMemberBillingScreenRoutes(prisma),
    CfoInvoicesScreenRoutes(prisma),
    AdminInvoicesScreenRoutes(prisma),
    AdminPaymentsScreenRoutes(prisma),
    BillingAdminDashboardScreenRoutes(prisma),
    BillingAdminInvoicesScreenRoutes(prisma),
  ];
}
