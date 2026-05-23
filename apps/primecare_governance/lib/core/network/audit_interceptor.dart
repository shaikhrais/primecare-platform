// Governance - Category: service | Purpose: Core implementation file for the Audit Interceptor platform logic.
import 'package:dio/dio.dart';
import '../services/audit_service.dart';

class AuditInterceptor extends Interceptor {
  final AuditService _auditService;

  AuditInterceptor(this._auditService);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _auditService.logAction(
      'API_REQUEST',
      'Path: ${response.requestOptions.path}, Status: ${response.statusCode}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _auditService.logAction(
      'API_ERROR',
      'Path: ${err.requestOptions.path}, Error: ${err.message}',
    );
    super.onError(err, handler);
  }
}
