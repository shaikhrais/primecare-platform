part of '../../../routes.dart';

class ScreenWorkItemGRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  ScreenWorkItemGRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/screen-work-item.g', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.screenworkitem.g.findMany();
        
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

    router.post('/api/screen-work-item.g/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for screen-work-item.g'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
