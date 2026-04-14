import 'package:dio/dio.dart';

/// States of the circuit breaker.
enum CircuitState { closed, open, halfOpen }

/// Circuit breaker that prevents cascading failures by short-circuiting requests
/// when the backend is detected as unhealthy.
///
/// State machine:
/// - CLOSED: Normal operation. Failures are counted.
/// - OPEN: Backend is down. All requests are immediately rejected (no HTTP call).
/// - HALF-OPEN: After a cooldown, allows a single probe request through.
///   If it succeeds → CLOSED. If it fails → OPEN again.
class CircuitBreaker {
  /// Number of consecutive failures before tripping to OPEN.
  final int failureThreshold;

  /// How long to wait in OPEN state before allowing a probe (HALF-OPEN).
  final Duration resetTimeout;

  CircuitState _state = CircuitState.closed;
  int _consecutiveFailures = 0;
  DateTime? _lastFailureTime;

  CircuitBreaker({
    this.failureThreshold = 5,
    this.resetTimeout = const Duration(seconds: 30),
  });

  CircuitState get state => _state;
  int get consecutiveFailures => _consecutiveFailures;

  /// Whether a request should be allowed through.
  bool get allowRequest {
    switch (_state) {
      case CircuitState.closed:
        return true;
      case CircuitState.open:
        // Check if cooldown has elapsed
        if (_lastFailureTime != null &&
            DateTime.now().difference(_lastFailureTime!) > resetTimeout) {
          _state = CircuitState.halfOpen;
          return true; // Allow one probe
        }
        return false; // Still cooling down
      case CircuitState.halfOpen:
        return true; // Already in probe mode
    }
  }

  /// Record a successful response. Resets the breaker.
  void recordSuccess() {
    _consecutiveFailures = 0;
    _state = CircuitState.closed;
  }

  /// Record a failure. May trip the breaker to OPEN.
  void recordFailure() {
    _consecutiveFailures++;
    _lastFailureTime = DateTime.now();

    if (_consecutiveFailures >= failureThreshold) {
      _state = CircuitState.open;
    }
  }

  /// Force reset the breaker (e.g., after re-auth or manual intervention).
  void reset() {
    _consecutiveFailures = 0;
    _state = CircuitState.closed;
    _lastFailureTime = null;
  }
}

/// Dio interceptor that wires the CircuitBreaker into the HTTP pipeline.
class CircuitBreakerInterceptor extends Interceptor {
  final CircuitBreaker breaker;

  CircuitBreakerInterceptor({CircuitBreaker? breaker})
      : breaker = breaker ?? CircuitBreaker();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!breaker.allowRequest) {
      // Short-circuit: don't even attempt the HTTP call
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          message:
              'Circuit breaker OPEN — backend appears unhealthy. '
              'Request blocked to prevent cascade. '
              'Will probe in ${breaker.resetTimeout.inSeconds}s.',
        ),
        true, // callFollowing: true to allow error interceptors to fire
      );
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    breaker.recordSuccess();
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Only count server-side failures, not client errors (4xx)
    final statusCode = err.response?.statusCode;
    final isServerError = statusCode != null && statusCode >= 500;
    final isNetworkError = err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;

    if (isServerError || isNetworkError) {
      breaker.recordFailure();
    }

    return handler.next(err);
  }
}
