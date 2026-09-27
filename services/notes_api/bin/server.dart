// Governance - Category: service | Purpose: Edge API service engine running request listeners and background worker micro-tasks.
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main() async {
  final router = Router();
  router.get('/', (Request request) => Response.ok('Hello from notes-api (Migrated to Dart)'));
  final handler = const Pipeline().addMiddleware(logRequests()).addMiddleware(corsHeaders()).addHandler(router.call);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  await serve(handler, InternetAddress.anyIPv4, port);
  print('notes-api serving at http://0.0.0.0:$port');
}
