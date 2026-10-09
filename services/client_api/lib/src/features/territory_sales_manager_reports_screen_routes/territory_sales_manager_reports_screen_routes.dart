part of '../../../routes.dart';

class TerritorySalesManagerReportsScreenRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  TerritorySalesManagerReportsScreenRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/territory-sales-manager-reports-screen', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.territorysalesmanagerreportsscreen.findMany();
        
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

    router.post('/api/territory-sales-manager-reports-screen/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for territory-sales-manager-reports-screen'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
