import 'dart:math' as math;
import 'package:dio/dio.dart';

/// Configurable retry policy for transient network failures.
/// Uses exponential backoff with jitter to prevent thundering herd.
class RetryPolicy {
  /// Maximum number of retry attempts (excludes the initial request).
  final int maxRetries;

  /// Base delay for the first retry. Subsequent retries double this.
  final Duration baseDelay;

  /// Maximum delay cap to prevent excessively long waits.
  final Duration maxDelay;

  /// HTTP status codes that should trigger a retry.
  final Set<int> retryableStatusCodes;

  /// DioException types that should trigger a retry.
  final Set<DioExceptionType> retryableExceptionTypes;

  const RetryPolicy({
    this.maxRetries = 2,
    this.baseDelay = const Duration(milliseconds: 500),
    this.maxDelay = const Duration(seconds: 8),
    this.retryableStatusCodes = const {408, 429, 500, 502, 503, 504},
    this.retryableExceptionTypes = const {
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.connectionError,
    },
  });

  /// Calculates the delay for a given attempt using exponential backoff + jitter.
  Duration getDelay(int attempt) {
    final exponentialMs = baseDelay.inMilliseconds * math.pow(2, attempt);
    final cappedMs = math.min(exponentialMs.toInt(), maxDelay.inMilliseconds);
    // Add 0-25% jitter to prevent thundering herd
    final jitter = (math.Random().nextDouble() * 0.25 * cappedMs).toInt();
    return Duration(milliseconds: cappedMs + jitter);
  }

  /// Whether a given DioException should trigger a retry.
  bool shouldRetry(DioException error) {
    // Don't retry mutations (POST/PUT/DELETE) unless idempotent
    final method = error.requestOptions.method.toUpperCase();
    if (method != 'GET' && method != 'HEAD' && method != 'OPTIONS') {
      return false;
    }

    if (retryableExceptionTypes.contains(error.type)) {
      return true;
    }

    final statusCode = error.response?.statusCode;
    if (statusCode != null && retryableStatusCodes.contains(statusCode)) {
      return true;
    }

    return false;
  }
}

/// Dio interceptor that implements retry with exponential backoff.
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final RetryPolicy policy;

  RetryInterceptor({required this.dio, RetryPolicy? policy})
    : policy = policy ?? const RetryPolicy();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!policy.shouldRetry(err)) {
      return handler.next(err);
    }

    // Track attempt count via request extras
    final extras = err.requestOptions.extra;
    final attempt = (extras['_retryAttempt'] as int?) ?? 0;

    if (attempt >= policy.maxRetries) {
      // Exhausted all retries — propagate the error
      return handler.next(err);
    }

    // Calculate backoff delay
    final delay = policy.getDelay(attempt);

    // Wait before retrying
    await Future.delayed(delay);

    // Clone the request with incremented attempt counter
    final options = err.requestOptions;
    options.extra['_retryAttempt'] = attempt + 1;

    try {
      final response = await dio.fetch(options);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    }
  }
}
