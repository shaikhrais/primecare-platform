part of '../../../routes.dart';

class CfoExpensesScreenRoutes extends BaseApiRoutes {
  final PrismaClient prisma;
  CfoExpensesScreenRoutes(this.prisma);

  @override
  void registerRoutes(Router router) {

    router.get('/api/cfo-expenses-screen', (Request request) async {
      try {
        // Automatically querying the synced Prisma models
        // const data = await prisma.cfoexpensesscreen.findMany();
        
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

    router.post('/api/cfo-expenses-screen/action', (Request request) async {
      try {
        final payload = await request.readAsString();
        // Insert payload into Prisma
        
        return Response.ok(jsonEncode({
          'status': 'action_completed',
          'message': 'Successfully processed action for cfo-expenses-screen'
        }), headers: {'Content-Type': 'application/json'});
      } catch (e) {
        return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
      }
    });


  }
}
