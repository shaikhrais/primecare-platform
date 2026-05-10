import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:path/path.dart' as p;
import '../core/base_controller.dart';
import 'package:governance_api/src/repositories/governance_repository.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/models/governance_types.dart';
import 'package:flutter_core/models/platform_geometry.dart';
import 'package:flutter_core/governance/registry_scanner.dart';
import '../core/subsystem_scanner.dart';

class GovernanceController extends BaseController implements PrimeCareApi {
  final GovernanceRepository _repository;
  final IAuditScanner _scanner;

  GovernanceController(this._repository, this._scanner);

  /// Dynamically extracts implemented routes from the entire platform source code.
  List<String> get _implementedRoutes {
    final rootPath = _getMonorepoRoot();
    final platformResult = _scanner.scanPlatform(rootPath);
    return [
      ...platformResult.services.values.expand((r) => r),
      ...platformResult.apps.values.expand((r) => r),
    ];
  }

  String _getMonorepoRoot() {
    var dir = Directory.current;
    while (dir.path != dir.parent.path) {
      if (File(p.join(dir.path, 'docker-compose.yml')).existsSync() && 
          Directory(p.join(dir.path, 'services')).existsSync()) {
        return dir.path;
      }
      dir = dir.parent;
    }
    return Directory.current.path;
  }

  @override
  ApiMetadata get metadata => const ApiMetadata(
    id: 'GOVERNANCE_CORE',
    endpoint: '/api/governance',
    method: 'GET',
    allowedRoles: ['admin', 'super_admin'],
    subsystem: 'governance',
    lifecycleStatus: LifecycleStatus.completed,
  );

  // Apps
  Future<Response> getApps(Request request) async {
    try {
      final apps = await _repository.getApps();
      return success(apps);
    } catch (e) {
      return error('Failed to fetch apps: $e');
    }
  }

  // Roles
  Future<Response> getRoles(Request request) async {
    try {
      final roles = await _repository.getRoles();
      return success(roles);
    } catch (e) {
      return error('Failed to fetch roles: $e');
    }
  }

  // APIs
  Future<Response> getApis(Request request) async {
    try {
      final apis = await _repository.getApis();
      return success(apis);
    } catch (e) {
      return error('Failed to fetch apis: $e');
    }
  }

  // Audit
  Future<Response> performAudit(Request request) async {
    try {
      final apis = await _repository.getApis();
      final registeredApis = {
        for (final a in apis) a['id'].toString(): ApiMetadata(
          id: a['id'].toString(),
          endpoint: a['endpoint'],
          allowedRoles: [],
          designSize: PlatformSize(
            (a['design_size_width'] as num?)?.toDouble() ?? 3840,
            (a['design_size_height'] as num?)?.toDouble() ?? 2160,
          ),
        )
      };

      final rogueEndpoints = RegistryScanner.findRogueEndpoints(
        _implementedRoutes,
        registeredApis,
      );

      final violations = <Map<String, dynamic>>[];
      
      for (final api in apis) {
        if (api['design_size_width'] != 3840) {
          violations.add({
            'type': '4k_violation',
            'id': api['id'],
            'endpoint': api['endpoint'],
            'severity': 'medium',
          });
        }
      }

      for (final rogue in rogueEndpoints) {
        violations.add({
          'type': 'rogue_endpoint',
          'path': rogue,
          'severity': 'critical',
          'message': 'Endpoint exists in code but is NOT registered in Governance.',
        });
      }

      return success({
        'status': violations.isEmpty ? 'compliant' : 'drift_detected',
        'violations': violations,
        'summary': {
          'api_count': apis.length,
          'rogue_count': rogueEndpoints.length,
          'violation_count': violations.length,
          'compliance_percentage': apis.isEmpty ? 100 : ((apis.length - violations.where((v) => v['type'] == '4k_violation').length) / apis.length * 100).round(),
        }
      });
    } catch (e) {
      return error('Audit failed: $e');
    }
  }

  // Remediation
  Future<Response> remediateDrift(Request request) async {
    try {
      await _repository.remediate4KStandard();
      
      await _repository.logEvent(
        type: 'remediation',
        message: 'Forced 4K Standard Parity across all registered endpoints.',
        level: 'success',
      );

      return success({
        'status': 'remediation_complete',
        'action': 'forced_4k_standard',
      });
    } catch (e) {
      return error('Remediation failed: $e');
    }
  }

  // Telemetry
  Future<Response> getTelemetry(Request request) async {
    try {
      final events = await _repository.getEvents();
      return success(events);
    } catch (e) {
      return error('Failed to fetch telemetry: $e');
    }
  }

  // Platform Audit
  Future<Response> getPlatformAudit(Request request) async {
    try {
      final rootPath = _getMonorepoRoot();
      final result = _scanner.scanPlatform(rootPath);
      
      return success(result.toJson());
    } catch (e) {
      return error('Failed to perform platform audit: $e');
    }
  }

  /// Helper for middleware logging
  Future<void> logRequest(Request request) async {
    try {
      await _repository.logEvent(
        type: 'network_request',
        message: 'Handled ${request.method} ${request.url.path}',
        level: 'info',
        metadata: {
          'method': request.method,
          'path': request.url.path,
          'headers': request.headers,
        },
      );
    } catch (e) {
      print('[GOVERNANCE] Telemetry log failed: $e');
    }
  }
}
