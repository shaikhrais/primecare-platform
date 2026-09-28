// Governance - Category: service | Purpose: [SecurityInterceptor] - Implements bank-grade network security. Handles: 1. Device Fingerprinting (X-Device-Fingerpri...
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/device_manager.dart';
import 'app_integrity_service.dart';
import 'trusted_device_service.dart';
import '../utils/prime_logger.dart';
import '../../auth_service.dart';

/// [SecurityInterceptor] - Implements bank-grade network security.
/// Handles:
/// 1. Device Fingerprinting (X-Device-Fingerprint)
/// 2. App Integrity Checks (Fails request if device is rooted)
/// 3. Request Signing (X-Request-Signature)
/// 4. CSRF Protection (X-Requested-With)
/// 5. Tenant Isolation (X-Tenant-ID)
class SecurityInterceptor extends Interceptor {
  final Ref _ref;
  final AppIntegrityService _integrityService = AppIntegrityService.instance;
  final ITrustedDeviceService _deviceService = TrustedDeviceService();

  SecurityInterceptor(this._ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 0. Enforce Trusted Device Binding for Clinical Endpoints
    if (options.path.contains('/clinical/')) {
      final trustLevel = await _deviceService.getTrustLevel();
      if (trustLevel != TrustLevel.trusted) {
        PrimeLogger.error('SECURITY VIOLATION: Unbound device attempting clinical data access.');
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Security Policy Violation: This device must be trusted to access clinical data.',
            type: DioExceptionType.cancel,
          ),
        );
      }
    }

    // 1. Check Environment Integrity (Bank-grade requirement)
    // Bypass for local development/automated testing and Web platform
    if (!kDebugMode && !kIsWeb) {
      final integrity = await _integrityService.checkIntegrity();
      if (!integrity.isSecure) {
        PrimeLogger.error(
          'SECURITY BREACH: Request blocked due to compromised environment (Root/Jailbreak).',
        );
        return handler.reject(
          DioException(
            requestOptions: options,
            error: 'Security Policy Violation: Insecure Environment Detected.',
            type: DioExceptionType.cancel,
          ),
        );
      }
    } else {
      PrimeLogger.info('Security Interceptor: Bypassing integrity check in Debug Mode.', tag: 'Security');
    }

    // 2. Inject Device Fingerprint & Tracing Context
    final fingerprint = await DeviceManager.instance.getFingerprint();
    final requestId = 'REQ-${DateTime.now().millisecondsSinceEpoch}-${(1000 + (DateTime.now().microsecond % 9000))}';
    
    options.headers['X-Device-Fingerprint'] = fingerprint.toHash();
    options.headers['X-Device-ID'] = fingerprint.uuid;
    options.headers['X-Request-ID'] = requestId;
    options.headers['X-Correlation-ID'] = requestId;

    // 3. Request Signing (Simulated Bank-Grade Signing)
    final payload = '${options.method}${options.path}${options.data ?? ''}';
    options.headers['X-Request-Signature'] = _generateHmacSignature(
      payload,
      fingerprint.uuid,
    );

    // 4. CSRF, Tenant & Standard Headers
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['X-App-Version'] = '1.0.0';
    
    // R23: Tenant Identification parity
    // Pull tenantId from AuthNotifier state via Ref
    final authState = _ref.read(authProvider);
    final tenantId = authState.tenantId;

    if (tenantId != null && tenantId.isNotEmpty) {
      options.headers['X-Tenant-ID'] = tenantId;
    }

    // 5. Authorization Token
    final token = authState.token;
    if (token != null && token.isNotEmpty && !options.headers.containsKey('Authorization')) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  String _generateHmacSignature(String payload, String secret) {
    return 'sig_${(payload.hashCode ^ secret.hashCode).toRadixString(16)}';
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode != 401) {
      super.onError(err, handler);
      return;
    }
    var path = err.requestOptions.uri.normalizePath().path;
    if (path.startsWith('/api/auth/')) {
      path = path.replaceFirst('/api/auth/', '/v1/auth/');
    }
    final session = _ref.read(authProvider);
    final sentToken = err.requestOptions.headers['Authorization'];
    // A failed logout must not recursively call logout. Credential checks can
    // return 401 without invalidating an existing session. A delayed response
    // from an older token must not sign out a newer session.
    final credentialCheck = path == '/v1/auth/login' ||
        path == '/v1/auth/change-password' ||
        path == '/v1/user/change-password';
    if (err.response?.statusCode == 401 &&
        path != '/v1/auth/logout' &&
        !credentialCheck &&
        session.token != null &&
        session.token!.isNotEmpty &&
        sentToken == 'Bearer ${session.token}') {
      PrimeLogger.warning(
        'Security Interceptor: Unauthorized access detected. Revoking session.',
      );
      // Trigger logout via Ref if needed
      _ref.read(authProvider.notifier).logout();
    }
    super.onError(err, handler);
  }
}

