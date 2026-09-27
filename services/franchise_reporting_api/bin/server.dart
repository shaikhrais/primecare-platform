// Governance - Category: service | Purpose: Mount the 456 AI-generated routes
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:franchise_reporting_api/routes.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main() async {
  final router = Router();

  // Mount the 456 AI-generated routes
  final apiRoutes = ApiRoutes();
  router.mount('/', apiRoutes.router.call);
  router.get('/', (Request request) => Response.ok('Hello from franchise-reporting-api (Migrated to Dart)'));
  final handler = const Pipeline().addMiddleware(logRequests()).addMiddleware(corsHeaders()).addHandler(router.call);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  await serve(handler, InternetAddress.anyIPv4, port);
  print('franchise-reporting-api serving at http://0.0.0.0:$port');
}
