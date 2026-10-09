import 'package:shelf/shelf.dart';
import '../database/database_controller.dart';
import '../repositories/governance_repository.dart';
import 'governance_http_controller.dart';

/// Compatibility facade preserves existing static handler tear-offs.
class GovernanceController {
  static final db = DatabaseController.connection;
  static final _controller = GovernanceHttpController(GovernanceRepository(db));
  static GovernanceHttpController get instance => _controller;

  static Future<Response> getApps(Request request) => _controller.getApps(request);
  static Future<Response> createApp(Request request) => _controller.createApp(request);
  static Future<Response> getRoles(Request request) => _controller.getRoles(request);
  static Future<Response> createRole(Request request) => _controller.createRole(request);
  static Future<Response> getModules(Request request) => _controller.getModules(request);
  static Future<Response> createModule(Request request) => _controller.createModule(request);
  static Future<Response> getFeatures(Request request) => _controller.getFeatures(request);
  static Future<Response> createFeature(Request request) => _controller.createFeature(request);
  static Future<Response> getScreens(Request request) => _controller.getScreens(request);
  static Future<Response> createScreen(Request request) => _controller.createScreen(request);
  static Future<Response> getRoutes(Request request) => _controller.getRoutes(request);
  static Future<Response> createRoute(Request request) => _controller.createRoute(request);
  static Future<Response> getApis(Request request) => _controller.getApis(request);
  static Future<Response> createApi(Request request) => _controller.createApi(request);
  static Future<Response> getPermissions(Request request) => _controller.getPermissions(request);
  static Future<Response> createPermission(Request request) => _controller.createPermission(request);
  static Future<Response> getLanguages(Request request) => _controller.getLanguages(request);
  static Future<Response> createLanguage(Request request) => _controller.createLanguage(request);
  static Future<Response> getStatuses(Request request) => _controller.getStatuses(request);
  static Future<Response> createStatus(Request request) => _controller.createStatus(request);
}
