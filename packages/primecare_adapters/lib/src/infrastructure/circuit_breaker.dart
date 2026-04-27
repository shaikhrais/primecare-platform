// Layer: 01_INFRASTRUCTURE
import 'package:dio/dio.dart';

enum CircuitState { closed, open, halfOpen }

/// Core State Machine for the Circuit Breaker pattern.
class CircuitBreaker {
  final int failureThreshold;
  final Duration resetTimeout;

  int _failureCount = 0;
  DateTime? _lastFailureTime;
  CircuitState _state = CircuitState.closed;

  CircuitBreaker({
    this.failureThreshold = 3,
    this.resetTimeout = const Duration(seconds: 30),
  });

  CircuitState get state {
    if (_state == CircuitState.open && _lastFailureTime != null) {
      if (DateTime.now().difference(_lastFailureTime!) > resetTimeout) {
        return CircuitState.halfOpen;
      }
    }
    return _state;
  }

  bool get allowRequest {
    final s = state;
    return s == CircuitState.closed || s == CircuitState.halfOpen;
  }

  void recordFailure() {
    _failureCount++;
    _lastFailureTime = DateTime.now();
    if (_failureCount >= failureThreshold) {
      _state = CircuitState.open;
    }
  }

  void recordSuccess() {
    _failureCount = 0;
    _lastFailureTime = null;
    _state = CircuitState.closed;
  }
}

/// Circuit Breaker Interceptor for PrimeCare Platform.
/// Prevents the system from making requests to an unhealthy backend.
class CircuitBreakerInterceptor extends Interceptor {
  final CircuitBreaker _breaker;

  CircuitBreakerInterceptor([CircuitBreaker? breaker])
    : _breaker = breaker ?? CircuitBreaker();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_breaker.allowRequest) {
      return handler.reject(
        DioException(
          requestOptions: options,
          message: 'Circuit is OPEN. Operations suspended for recovery.',
          type: DioExceptionType.cancel,
        ),
      );
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      _breaker.recordFailure();
    } else {
      _breaker.recordSuccess();
    }
    return handler.next(err);
  }
}
