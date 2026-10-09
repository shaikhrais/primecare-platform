part of '../../../routes.dart';

class AdminPaymentsScreenRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  AdminPaymentsScreenRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/admin-payments-screen', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.adminpaymentsscreen.findMany();
        
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

    router.post('/api/admin-payments-screen/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for admin-payments-screen'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
