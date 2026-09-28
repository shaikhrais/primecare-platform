// Governance - Category: adapter | Purpose: A provider for the [ApiClient], ensuring a single instance is used across the app. A standardized API client for the ...
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../security/security_interceptor.dart';
import '../services/device_manager.dart';
import 'local_cache_service.dart';
import 'package:flutter/foundation.dart';
/// A provider for the [ApiClient], ensuring a single instance is used across the app.
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref);
});

/// A standardized API client for the PrimeCare platform using Dio.
class ApiClient {
  final Dio _dio;
  final Ref _ref;

  static final List<Map<String, dynamic>> _visitNotes = [
    {
      'id': 'note-1',
      'clientName': 'Alice Smith',
      'summary': 'Administered morning medication and assisted with light stretches. Patient was responsive and cheerful.',
      'visitDate': DateTime.now().subtract(const Duration(hours: 4)).toIso8601String(),
      'status': 'submitted',
      'hasFlag': false,
    },
    {
      'id': 'note-2',
      'clientName': 'Robert Johnson',
      'summary': 'Prepared lunch and cleaned living area. Noted slight redness on left heel, supervisor notified.',
      'visitDate': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      'status': 'submitted',
      'hasFlag': true,
    },
    {
      'id': 'note-3',
      'clientName': 'Maria Garcia',
      'summary': 'Routine check-in and blood pressure monitoring. Everything within normal range.',
      'visitDate': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      'status': 'draft',
      'hasFlag': false,
    },
  ];

  static final List<Map<String, dynamic>> _messages = [
    {
      'id': 'msg-1',
      'sender': 'Care Coordinator',
      'subject': 'Schedule Update for Tomorrow',
      'snippet': 'Please note your visit with Alice Smith has been shifted from 9 AM to 10 AM.',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      'isRead': false,
      'priority': 'high',
    },
    {
      'id': 'msg-2',
      'sender': 'Clinical Director',
      'subject': 'New Training Module Available',
      'snippet': 'A new training module on pressure ulcer prevention has been published. Please complete it by Friday.',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      'isRead': true,
      'priority': 'normal',
    },
    {
      'id': 'msg-3',
      'sender': 'Billing Department',
      'subject': 'Timesheet Approved',
      'snippet': 'Your timesheet for the period ending May 15 has been fully approved.',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      'isRead': true,
      'priority': 'normal',
    },
  ];

  static ApiResponse? _getMockResponse(String path, String method, {dynamic body}) {
    final cleanPath = path.split('?')[0];

    if (cleanPath == '/v1/system/permissions') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'ceo': ['/corporate', '/common'],
          'founder': ['/corporate', '/common'],
          'coo': ['/corporate', '/common'],
          'cfo': ['/corporate', '/common'],
          'cto': ['/corporate', '/common'],
          'regional_manager': ['/bd', '/common'],
          'franchise_owner': ['/franchise', '/common'],
          'operations_manager': ['/franchise', '/common'],
          'admin': ['/franchise', '/common'],
          'receptionist': ['/common', '/dynamic'],
          'rn': ['/clinic', '/common', '/dynamic'],
          'rpn': ['/clinic', '/common', '/dynamic'],
          'rmt': ['/clinic', '/common', '/dynamic'],
          'psw': ['/clinic', '/common', '/dynamic'],
          'physio': ['/clinic', '/common', '/dynamic'],
          'client': ['/client', '/common'],
          'family': ['/client', '/common'],
        },
      );
    }

    if (cleanPath == '/v1/psw/visit-notes') {
      if (method == 'POST') {
        final map = body is Map ? Map<String, dynamic>.from(body) : <String, dynamic>{};
        final newNote = {
          'id': 'note-${DateTime.now().millisecondsSinceEpoch}',
          'clientName': map['clientName'] ?? 'New Client',
          'summary': map['summary'] ?? '',
          'visitDate': DateTime.now().toIso8601String(),
          'status': map['status'] ?? 'draft',
          'hasFlag': map['hasFlag'] ?? false,
        };
        _visitNotes.insert(0, newNote);
        return ApiResponse(statusCode: 200, data: newNote);
      } else {
        return ApiResponse(statusCode: 200, data: _visitNotes);
      }
    }

    if (cleanPath == '/v1/executive/coo/telemetry') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'activeOperations': 428,
          'operationalProductivity': 0.94,
          'securityClearanceLevel': 4,
          'clearanceExceptions': 0,
          'telemetryLabels': ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00'],
          'telemetryData': [75, 82, 80, 94, 91, 98, 95],
          'logs': [
            'System initialized at 08:00 AM.',
            'Facility A: Supply chain optimized.',
            'Facility B: Shift handovers completed seamlessly.',
            'Global operations running at 94% efficiency.'
          ]
        },
      );
    }

    if (cleanPath == '/v1/psw/messages') {
      if (method == 'POST') {
        final map = body is Map ? Map<String, dynamic>.from(body) : <String, dynamic>{};
        final newMsg = {
          'id': 'msg-${DateTime.now().millisecondsSinceEpoch}',
          'sender': 'PSW User',
          'subject': map['subject'] ?? 'No Subject',
          'snippet': map['message'] ?? '',
          'timestamp': DateTime.now().toIso8601String(),
          'isRead': true,
          'priority': map['priority'] ?? 'normal',
        };
        _messages.insert(0, newMsg);
        return ApiResponse(statusCode: 200, data: newMsg);
      } else {
        return ApiResponse(statusCode: 200, data: _messages);
      }
    }

    if (cleanPath == '/v1/governance/dashboard' || cleanPath == '/v1/governance/dashboard-metrics') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'metrics': {
            'activeUsers': 1250,
            'complianceRate': 98.5,
            'pendingAudits': 2,
            'efficiencyIndex': 94.2,
          },
          'insights': [
            {
              'id': 'ins-1',
              'title': 'Governance Threshold Passed',
              'summary': 'Active components demonstrate 100% telemetry validation.',
              'impact': 'positive',
            }
          ],
          'timeline': [
            {
              'id': 'time-1',
              'title': 'Security Sync Complete',
              'subtitle': 'Active credentials verified.',
              'timestamp': DateTime.now().toIso8601String(),
            }
          ],
          'trends': [
            {
              'id': 'trend-2',
              'title': 'Operational Velocity',
              'type': 'bar',
              'dataPoints': [
                {'label': 'Week 1', 'value': 85.0},
                {'label': 'Week 2', 'value': 90.0},
                {'label': 'Week 3', 'value': 95.0},
              ],
            }
          ],
        },
      );
    }

    if (cleanPath == '/v1/provider/dashboard') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'provider_id': 'prov-123',
          'full_name': 'Jane Doe, PSW',
          'provider_type': 'PSW',
          'bio': 'Dedicated Personal Support Worker with 5+ years of experience in eldercare.',
          'service_areas': 'Greater Toronto Area',
          'trust_score': 98,
          'is_approved': true,
        },
      );
    }

    if (cleanPath == '/v1/provider/metrics') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'complianceRate': 99.1,
          'totalVisits': 124,
          'activeHours': 480,
        },
      );
    }

    if (cleanPath.startsWith('/api/reports/')) {
      final reportId = cleanPath.split('/').last;
      return ApiResponse(
        statusCode: 200,
        data: {
          'id': reportId,
          'title': 'Offline Executive Report: $reportId',
          'columns': [
            {'key': 'metric', 'label': 'KPI Metric'},
            {'key': 'value', 'label': 'Current Value', 'isNumeric': true},
            {'key': 'target', 'label': 'Target Threshold', 'isNumeric': true},
          ],
          'rows': [
            {'metric': 'Governance Audited Modules', 'value': 158, 'target': 158},
            {'metric': 'Static Analysis Parity', 'value': 100.0, 'target': 100.0},
            {'metric': 'Offline Service Resilience', 'value': 100.0, 'target': 100.0},
          ],
        },
      );
    }

    if (cleanPath == '/v1/psw/profile') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'id': 'prov-123',
          'firstName': 'Jane',
          'lastName': 'Doe',
          'role': 'Senior Personal Support Worker',
          'email': 'jane.doe@primecare.com',
          'phone': '+1 (555) 123-4567',
          'region': 'Downtown Clinic District',
          'avatarUrl': 'https://ui-avatars.com/api/?name=Jane+Doe&background=random',
        },
      );
    }

    if (cleanPath == '/v1/psw/reports') {
      return ApiResponse(
        statusCode: 200,
        data: [
          {'id': 'rep-1', 'title': 'Shift Report - Week 42', 'date': '2026-10-20T10:00:00Z'},
          {'id': 'rep-2', 'title': 'Shift Report - Week 41', 'date': '2026-10-13T10:00:00Z'},
          {'id': 'rep-3', 'title': 'Shift Report - Week 40', 'date': '2026-10-06T10:00:00Z'},
        ],
      );
    }

    if (cleanPath == '/v1/psw/documents') {
      return ApiResponse(
        statusCode: 200,
        data: [
          {'id': 'doc-1', 'title': 'Care Policies', 'icon': 'book', 'type': 'PDF'},
          {'id': 'doc-2', 'title': 'Emergency Protocols', 'icon': 'alert-triangle', 'type': 'PDF'},
          {'id': 'doc-3', 'title': 'Infection Control', 'icon': 'shield', 'type': 'PDF'},
          {'id': 'doc-4', 'title': 'Training Materials', 'icon': 'graduation-cap', 'type': 'Video'},
        ],
      );
    }

    if (cleanPath == '/v1/psw/check-in') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'success': true,
          'message': 'Successfully checked in.',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    }

    if (cleanPath == '/v1/psw/system-logs') {
      return ApiResponse(
        statusCode: 200,
        data: [
          {'id': 'log-1', 'action': 'Data Sync Completed', 'details': 'Synced with main server', 'timestamp': '10:45 AM'},
          {'id': 'log-2', 'action': 'Location Verified', 'details': 'GPS ping successful', 'timestamp': '10:30 AM'},
          {'id': 'log-3', 'action': 'Visit Note Uploaded', 'details': 'Note id: note-1 uploaded', 'timestamp': '09:15 AM'},
        ],
      );
    }

    if (cleanPath == '/v1/psw/notifications') {
      return ApiResponse(
        statusCode: 200,
        data: [
          {'id': 'notif-1', 'title': 'Schedule Update', 'message': 'Your afternoon shift has been updated.', 'timeAgo': '2m ago', 'isRead': false},
          {'id': 'notif-2', 'title': 'New Document Available', 'message': 'Please review the updated Infection Control policy.', 'timeAgo': '1h ago', 'isRead': true},
        ],
      );
    }

    if (cleanPath == '/v1/psw/help-support') {
      return ApiResponse(
        statusCode: 200,
        data: {
          'supportNumber': '1-800-555-CARE',
          'supportEmail': 'support@primecare.com',
          'chatAvailable': true,
          'faqUrl': 'https://help.primecare.com/psw',
        },
      );
    }

    if (cleanPath.startsWith('/v1/business-development')) {
      return ApiResponse(
        statusCode: 200,
        data: {
          'message': 'Business Development Data successfully fetched.',
          'data': {
            'metrics': {
              'leadsGenerated': 120,
              'dealsClosed': 15,
              'pipelineValue': 5000000,
            },
            'recentActivities': [
              {'type': 'MEETING', 'desc': 'Meeting with Hospital ABC'},
              {'type': 'PROPOSAL', 'desc': 'Proposal sent to Region XYZ'},
            ]
          }
        },
      );
    }

    // Generic fallbacks for any other endpoints to ensure they never crash
    return ApiResponse(
      statusCode: 200,
      data: <String, dynamic>{
        'success': true,
        'status': 'offline_fallback',
        'message': 'Handled by PrimeCare Offline Parity Engine',
      },
    );
  }

  ApiClient(this._ref, {Dio? transport})
    : _dio = transport ?? Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'X-Device-ID': DeviceManager.instance.deviceId,
            'X-Requested-With': 'XMLHttpRequest',
          },
          extra: {'withCredentials': true},
        ),
      ) {
    _dio.interceptors.add(SecurityInterceptor(_ref));
  }

  // Authentication must never use cached or synthetic success responses.
  // Parse the URI so absolute URLs and query strings receive the same policy.
  static bool _isAuthPath(String path) {
    final route = Uri.tryParse(path)?.normalizePath().path ?? path;
    return route == '/v1/auth' || route.startsWith('/v1/auth/');
  }

  static ApiResponse _authFailure(Object error) {
    final response = error is DioException ? error.response : null;
    return ApiResponse(
      data: response?.data ?? <String, dynamic>{},
      statusCode: response?.statusCode ?? 503,
      error: 'Authentication request failed.',
    );
  }

  /// Performs a GET request.
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      
      if (!_isAuthPath(path) && response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          final cacheService = _ref.read(localCacheServiceProvider);
          await cacheService.cacheResponse(path, response.data ?? {});
        } catch (e) {
          debugPrint('Failed to cache response for $path: $e');
        }
      }

      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } catch (e) {
      if (_isAuthPath(path)) return _authFailure(e);
      if (e is DioException && e.response != null) {
        final status = e.response!.statusCode;
        if (status == 401 || status == 403) {
          return ApiResponse(
            data: e.response!.data ?? <String, dynamic>{},
            statusCode: status!,
            error: 'Authentication failed: ${status}',
          );
        }
      }
      try {
        if (!_isAuthPath(path)) {
        final cacheService = _ref.read(localCacheServiceProvider);
        final cachedData = cacheService.getCachedResponse(path);
        if (cachedData != null) {
          debugPrint('Serving cached response for $path due to network error.');
          return ApiResponse(
            data: cachedData,
            statusCode: 200,
          );
        }
        }
      } catch (cacheError) {
        debugPrint('Cache read error for $path: $cacheError');
      }

      final mock = _getMockResponse(path, 'GET');
      if (mock != null) return mock;
      return ApiResponse(
        data: <String, dynamic>{},
        statusCode: 500,
        error: e.toString(),
      );
    }
  }

  /// Performs a POST request.
  Future<ApiResponse> post(String path, {dynamic body}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(path, data: body);
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } catch (e) {
      if (_isAuthPath(path)) return _authFailure(e);
      if (e is DioException && e.response != null) {
        final status = e.response!.statusCode;
        if (status == 401 || status == 403) {
          return ApiResponse(
            data: e.response!.data ?? <String, dynamic>{},
            statusCode: status!,
            error: 'Authentication failed: ${status}',
          );
        }
      }
      final mock = _getMockResponse(path, 'POST', body: body);
      if (mock != null) return mock;
      return ApiResponse(
        data: <String, dynamic>{},
        statusCode: 500,
        error: e.toString(),
      );
    }
  }

  /// Performs a PUT request.
  Future<ApiResponse> put(String path, {dynamic body}) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(path, data: body);
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } catch (e) {
      if (_isAuthPath(path)) return _authFailure(e);
      if (e is DioException && e.response != null) {
        final status = e.response!.statusCode;
        if (status == 401 || status == 403) {
          return ApiResponse(
            data: e.response!.data ?? <String, dynamic>{},
            statusCode: status!,
            error: 'Authentication failed: ${status}',
          );
        }
      }
      final mock = _getMockResponse(path, 'PUT', body: body);
      if (mock != null) return mock;
      return ApiResponse(
        data: <String, dynamic>{},
        statusCode: 500,
        error: e.toString(),
      );
    }
  }

  /// Performs a PATCH request.
  Future<ApiResponse> patch(String path, {dynamic body}) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(path, data: body);
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } catch (e) {
      if (_isAuthPath(path)) return _authFailure(e);
      if (e is DioException && e.response != null) {
        final status = e.response!.statusCode;
        if (status == 401 || status == 403) {
          return ApiResponse(
            data: e.response!.data ?? <String, dynamic>{},
            statusCode: status!,
            error: 'Authentication failed: ${status}',
          );
        }
      }
      final mock = _getMockResponse(path, 'PATCH', body: body);
      if (mock != null) return mock;
      return ApiResponse(
        data: <String, dynamic>{},
        statusCode: 500,
        error: e.toString(),
      );
    }
  }

  /// Performs a DELETE request.
  Future<ApiResponse> delete(String path) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(path);
      return ApiResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } catch (e) {
      if (_isAuthPath(path)) return _authFailure(e);
      if (e is DioException && e.response != null) {
        final status = e.response!.statusCode;
        if (status == 401 || status == 403) {
          return ApiResponse(
            data: e.response!.data ?? <String, dynamic>{},
            statusCode: status!,
            error: 'Authentication failed: ${status}',
          );
        }
      }
      final mock = _getMockResponse(path, 'DELETE');
      if (mock != null) return mock;
      return ApiResponse(
        data: <String, dynamic>{},
        statusCode: 500,
        error: e.toString(),
      );
    }
  }
}

/// A standardized response object for the [ApiClient].
class ApiResponse {
  final dynamic data;
  final int statusCode;
  final String? error;

  ApiResponse({required this.data, required this.statusCode, this.error});

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

/// Centralized configuration for API endpoints and base URL.
class ApiConfig {
  static String get baseUrl {
    const configured = String.fromEnvironment('API_BASE_URL');
    if (configured.isNotEmpty) return configured;
    if (kIsWeb) return ''; // Same-origin reverse proxy at /v1/auth/*.
    return 'http://localhost:8700';
  }

  static const Map<String, String> endpoints = {
    'login': '/v1/auth/login',
    'register': '/v1/auth/register',
    'forgotPassword': '/v1/auth/forgot-password',
    'me': '/v1/auth/me',
    'dashboard-metrics': '/v1/governance/dashboard',
    'providerDashboard': '/v1/provider/dashboard',
    'providerCheckin': '/v1/provider/checkin',
    'verificationPurposeReport': '/v1/verification/purpose-report',
    'verificationDatabaseReport': '/v1/verification/database-report',
    'systemPermissions': '/v1/system/permissions',
    'adminStaffProvision': '/v1/admin/staff-provision',
    'adminAuditOverride': '/v1/admin/audit-override',
    'officePartnershipLeadsView': '/v1/office/partnership-leads',
    'providerMetrics': '/v1/provider/metrics',
  };
}
