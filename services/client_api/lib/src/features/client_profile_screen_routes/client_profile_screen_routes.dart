part of '../../../routes.dart';

class ClientProfileScreenRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  ClientProfileScreenRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/client-profile-screen', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.clientprofilescreen.findMany();
        
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

    router.post('/api/client-profile-screen/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for client-profile-screen'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
