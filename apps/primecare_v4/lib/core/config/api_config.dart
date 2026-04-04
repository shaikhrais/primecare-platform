import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized Integration Layer defining exact Backend routing addresses.
class ApiConfig {
  /// Base API destination URL (e.g. gateway edge proxy)
  static String get baseUrl => dotenv.env['API_URL'] ?? 'https://primecare-api-gateway.itpro-mohammed.workers.dev';
  
  /// Global Semantic Versioning flag injected natively into the uri strings
  static const String version = 'v1';

  /// Immutable dictionary mapping the physical endpoints.
  /// If the backend changes a routing path, you ONLY update this value here.
  static const Map<String, String> endpoints = {
    'login': '/auth/login',
    'register': '/auth/register',
    
    'providerDashboard': '/providers/profile/me',
    'providerMetrics': '/dashboard/metrics',
    'providerCheckin': '/visits/:visitId/checkin',
    
    'intakeCases': '/intake/cases',
    'carePlansUpdate': '/care-plans/update',
    'trainingComplete': '/training/complete',
    'supportEscalate': '/support/tickets/escalate',
    'franchiseTerritoryUpdate': '/franchise/territory/update',
    'reportingSummary': '/reporting/summary',
  };
}
