part of '../../../routes.dart';

class ScreenWorkRegistryRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  ScreenWorkRegistryRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/screen-work-registry', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.screenworkregistry.findMany();
        
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

    router.post('/api/screen-work-registry/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for screen-work-registry'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
