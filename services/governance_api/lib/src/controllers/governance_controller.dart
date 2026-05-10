import 'package:shelf/shelf.dart';
import '../core/base_controller.dart';
import 'package:governance_api/src/repositories/governance_repository.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/models/governance_types.dart';
import 'package:flutter_core/models/platform_geometry.dart';
import 'package:flutter_core/governance/registry_scanner.dart';
import '../core/subsystem_scanner.dart';

class GovernanceController extends BaseController implements PrimeCareApi {
  final GovernanceRepository _repository;

  /// Dynamically extracts implemented routes from the entire platform source code.
  List<String> get _implementedRoutes {
    final rootPath = Directory.current.parent.parent.path;
    final platformRoutes = SubsystemScanner.scanPlatform(rootPath);
    return platformRoutes.values.expand((r) => r).toList();
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

  GovernanceController(this._repository);

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
      
      // Convert database rows to ApiMetadata map for scanning
      final registeredApis = {
        for (final a in apis) a['id'].toString(): ApiMetadata(
          id: a['id'].toString(),
          endpoint: a['endpoint'],
          allowedRoles: [], // Simplified for audit
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
      
      // Check for 4K compliance and Rogue status
      for (final api in apis) {
        if (api['design_size_width'] != 3840) {
          violations.add({
            'type': '4k_violation',
            'id': api['id'],
            'endpoint': api['endpoint'],
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
      final rootPath = Directory.current.parent.parent.path;
      final platformRoutes = SubsystemScanner.scanPlatform(rootPath);
      
      return success({
        'timestamp': DateTime.now().toIso8601String(),
        'root': rootPath,
        'services_scanned': platformRoutes.keys.length,
        'discovery': platformRoutes,
      });
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
