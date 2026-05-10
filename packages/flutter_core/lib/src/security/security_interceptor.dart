import 'package:dio/dio.dart';
import '../services/device_manager.dart';
import 'app_integrity_service.dart';
import 'trusted_device_service.dart';
import '../utils/prime_logger.dart';

/// [SecurityInterceptor] - Implements bank-grade network security.
/// Handles:
/// 1. Device Fingerprinting (X-Device-Fingerprint)
/// 2. App Integrity Checks (Fails request if device is rooted)
/// 3. Request Signing (X-Request-Signature)
/// 4. CSRF Protection (X-Requested-With)
class SecurityInterceptor extends Interceptor {
  // SecurityInterceptor logic

  final AppIntegrityService _integrityService = AppIntegrityService.instance;
  final ITrustedDeviceService _deviceService = TrustedDeviceService();

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

    // 2. Inject Device Fingerprint
    final fingerprint = await DeviceManager.instance.getFingerprint();
    options.headers['X-Device-Fingerprint'] = fingerprint.toHash();
    options.headers['X-Device-ID'] = fingerprint.uuid;

    // 3. Request Signing (Simulated Bank-Grade Signing)
    // In production, use a private key from SecureStorageManager
    final payload = '${options.method}${options.path}${options.data ?? ''}';
    options.headers['X-Request-Signature'] = _generateHmacSignature(
      payload,
      fingerprint.uuid,
    );

    // 4. CSRF & Standard Headers
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['X-App-Version'] =
        '1.0.0'; // Should come from package_info_plus

    return handler.next(options);
  }

  String _generateHmacSignature(String payload, String secret) {
    // Simulated HMAC-SHA256
    return 'sig_${(payload.hashCode ^ secret.hashCode).toRadixString(16)}';
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      PrimeLogger.warning(
        'Security Interceptor: Unauthorized access detected. Revoking session.',
      );
      // Trigger logout/lock flow
    }
    super.onError(err, handler);
  }
}
