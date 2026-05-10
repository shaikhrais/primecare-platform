import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cross_subsystem_auditor.dart';

/// [NetworkParityService] - Bridges the UI with the Backend Governance API.
/// This service consumes the Max OOP MVC audit endpoints to provide real-time
/// compliance visualization in the HUD Dashboard.
class NetworkParityService {
  final String baseUrl;

  NetworkParityService({required this.baseUrl});

  /// Fetches the current audit status from the Governance API.
  /// Translates API violations into [AuditIssue] models for the UI.
  Future<List<AuditIssue>> fetchBackendAudit() async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/api/audit'));
      
      if (response.statusCode != 200) {
        throw Exception('Failed to connect to Governance API');
      }

      final data = jsonDecode(response.body);
      final List violations = data['violations'] ?? [];

      return violations.map((v) {
        return AuditIssue(
          id: 'backend_violation_${v['id'] ?? v['path'] ?? 'unknown'}',
          subsystem: 'governance_api',
          registry: 'ApiGovernanceRegistry',
          issue: v['type'] == 'rogue_endpoint' 
              ? 'Rogue Endpoint: ${v['path']}' 
              : '4K Standard Violation: ${v['endpoint']}',
          suggestion: v['type'] == 'rogue_endpoint'
              ? 'Register this path in ApiGovernanceRegistry to ensure compliance.'
              : 'Update the endpoint design size to 3840x2160.',
          autoRemediable: v['type'] == '4k_violation',
          metadata: v,
        );
      }).toList();
    } catch (e) {
      return [
        AuditIssue(
          id: 'backend_unreachable',
          subsystem: 'governance_api',
          registry: 'Network',
          issue: 'Backend Audit Unreachable',
          suggestion: 'Ensure the Governance API service is running on $baseUrl',
        )
      ];
    }
  }

  /// Fetches recent telemetry events from the Governance API.
  Future<List<Map<String, dynamic>>> fetchTelemetry() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/telemetry'));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Fetches the platform-wide audit (microservice discovery).
  Future<Map<String, dynamic>> fetchPlatformAudit() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/audit/platform'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return {'error': 'Failed to fetch platform audit', 'status': response.statusCode};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  /// Triggers the automated remediation workflow on the backend.
  Future<bool> remediateDrift() async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/api/remediate'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
