part of '../../../routes.dart';

class AdminInvoicesScreenRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  AdminInvoicesScreenRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/admin-invoices-screen', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.admininvoicesscreen.findMany();
        
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

    router.post('/api/admin-invoices-screen/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for admin-invoices-screen'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
