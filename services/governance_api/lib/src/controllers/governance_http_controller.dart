import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:server_core/server_core.dart';
import '../repositories/governance_repository.dart';

/// HTTP adaptation only; reviewed SQL remains in the repository.
class GovernanceHttpController extends BaseController {
  final GovernanceRepository repository;
  GovernanceHttpController(this.repository);

  Future<Response> getApps(Request request) async => success(await repository.getApps());

  Future<Response> createApp(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createApp(data);
    return _created();
  }

  Future<Response> getRoles(Request request) async => success(await repository.getRoles());

  Future<Response> createRole(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createRole(data);
    return _created();
  }

  Future<Response> getModules(Request request) async => success(await repository.getModules());

  Future<Response> createModule(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createModule(data);
    return _created();
  }

  Future<Response> getFeatures(Request request) async => success(await repository.getFeatures());

  Future<Response> createFeature(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createFeature(data);
    return _created();
  }

  Future<Response> getScreens(Request request) async => success(await repository.getScreens());

  Future<Response> createScreen(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createScreen(data);
    return _created();
  }

  Future<Response> getRoutes(Request request) async => success(await repository.getRoutes());

  Future<Response> createRoute(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createRoute(data);
    return _created();
  }

  Future<Response> getApis(Request request) async => success(await repository.getApis());

  Future<Response> createApi(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createApi(data);
    return _created();
  }

  Future<Response> getPermissions(Request request) async => success(await repository.getPermissions());

  Future<Response> createPermission(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createPermission(data);
    return _created();
  }

  Future<Response> getLanguages(Request request) async => success(await repository.getLanguages());

  Future<Response> createLanguage(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createLanguage(data);
    return _created();
  }

  Future<Response> getStatuses(Request request) async => success(await repository.getStatuses());

  Future<Response> createStatus(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await repository.createStatus(data);
    return _created();
  }

  Response _created() => Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
}
