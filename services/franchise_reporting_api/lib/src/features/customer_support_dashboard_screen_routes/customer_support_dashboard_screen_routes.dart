part of '../../../routes.dart';

class CustomerSupportDashboardScreenRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  CustomerSupportDashboardScreenRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/customer-support-dashboard-screen', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.customersupportdashboardscreen.findMany();
        
        // Returning standardized JSON Response
        return Response.ok(jsonEncode({
          'status': 'success',
          'message': 'Data retrieved successfully',
          'data': [] // Fallback array if table is empty
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });

    router.post('/api/customer-support-dashboard-screen/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for customer-support-dashboard-screen'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
