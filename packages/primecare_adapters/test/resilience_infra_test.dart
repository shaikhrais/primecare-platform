// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:dio/dio.dart';

void main() {
  group('CircuitBreaker State Machine', () {
    late CircuitBreaker breaker;

    setUp(() {
      breaker = CircuitBreaker(
        failureThreshold: 3,
        resetTimeout: const Duration(seconds: 2),
      );
    });

    test('starts in CLOSED state', () {
      expect(breaker.state, CircuitState.closed);
      expect(breaker.allowRequest, isTrue);
    });

    test('stays CLOSED below failure threshold', () {
      breaker.recordFailure();
      breaker.recordFailure();
      expect(breaker.state, CircuitState.closed);
      expect(breaker.allowRequest, isTrue);
    });

    test('transitions to OPEN after reaching failure threshold', () {
      breaker.recordFailure();
      breaker.recordFailure();
      breaker.recordFailure();
      expect(breaker.state, CircuitState.open);
      expect(breaker.allowRequest, isFalse);
    });

    test('resets failure count on success', () {
      breaker.recordFailure();
      breaker.recordFailure();
      breaker.recordSuccess();
      expect(breaker.state, CircuitState.closed);
      // After reset, it takes another full threshold to trip
      breaker.recordFailure();
      breaker.recordFailure();
      expect(breaker.state, CircuitState.closed);
    });

    test('transitions to HALF_OPEN after cooldown', () async {
      // Trip the breaker
      breaker.recordFailure();
      breaker.recordFailure();
      breaker.recordFailure();
      expect(breaker.state, CircuitState.open);

      // Wait for cooldown
      await Future<void>.delayed(const Duration(seconds: 3));

      expect(breaker.allowRequest, isTrue);
      expect(breaker.state, CircuitState.halfOpen);
    });

    test('HALF_OPEN returns to CLOSED on success', () async {
      breaker.recordFailure();
      breaker.recordFailure();
      breaker.recordFailure();
      await Future<void>.delayed(const Duration(seconds: 3));
      breaker.allowRequest; // trigger half-open
      breaker.recordSuccess();
      expect(breaker.state, CircuitState.closed);
    });

    test('HALF_OPEN returns to OPEN on failure', () async {
      breaker.recordFailure();
      breaker.recordFailure();
      breaker.recordFailure();
      await Future<void>.delayed(const Duration(seconds: 3));
      breaker.allowRequest; // trigger half-open
      breaker.recordFailure();
      expect(breaker.state, CircuitState.open);
    });
  });

  group('RetryPolicy', () {
    test('defaults are sane', () {
      const policy = RetryPolicy();
      expect(policy.maxRetries, 2);
      expect(policy.baseDelay, const Duration(milliseconds: 500));
      expect(policy.maxDelay, const Duration(seconds: 8));
    });

    test('calculates exponential delay', () {
      const policy = RetryPolicy();
      // Attempt 0: base * 2^0 = 500ms + up to 25% jitter
      final d0 = policy.getDelay(0);
      expect(d0.inMilliseconds, greaterThanOrEqualTo(500));
      expect(d0.inMilliseconds, lessThanOrEqualTo(625));

      // Attempt 1: base * 2^1 = 1000ms + jitter
      final d1 = policy.getDelay(1);
      expect(d1.inMilliseconds, greaterThanOrEqualTo(1000));
      expect(d1.inMilliseconds, lessThanOrEqualTo(1250));
    });

    test('caps delay at maxDelay', () {
      const policy = RetryPolicy(
        baseDelay: Duration(seconds: 5),
        maxDelay: Duration(seconds: 8),
      );
      final d = policy.getDelay(2);
      expect(d.inMilliseconds, lessThanOrEqualTo(10000));
    });

    test('only retries GET requests', () {
      const policy = RetryPolicy();
      expect(
        policy.shouldRetry(
          DioException(
            requestOptions: RequestOptions(path: '/', method: 'GET'),
            type: DioExceptionType.connectionError,
          ),
        ),
        isTrue,
      );
      expect(
        policy.shouldRetry(
          DioException(
            requestOptions: RequestOptions(path: '/', method: 'POST'),
            type: DioExceptionType.connectionError,
          ),
        ),
        isFalse,
      );
      expect(
        policy.shouldRetry(
          DioException(
            requestOptions: RequestOptions(path: '/', method: 'PUT'),
          ),
        ),
        isFalse,
      );
      expect(
        policy.shouldRetry(
          DioException(
            requestOptions: RequestOptions(path: '/', method: 'DELETE'),
          ),
        ),
        isFalse,
      );
    });

    test('does not retry POST by default', () {
      const policy = RetryPolicy(maxRetries: 2);
      expect(
        policy.shouldRetry(
          DioException(
            requestOptions: RequestOptions(path: '/', method: 'POST'),
          ),
        ),
        isFalse,
      );
    });
  });

  group('Result Pattern (regression)', () {
    test('Success.fold returns onSuccess value', () {
      final result = Success<String>('data');
      final value = result.fold((d) => 'got: $d', (e) => 'fail');
      expect(value, 'got: data');
    });

    test('Failure.fold returns onFailure value', () {
      final result = Failure<String>(Exception('boom'));
      final value = result.fold((d) => 'got: $d', (e) => 'recovered');
      expect(value, 'recovered');
    });

    test('Result.guardFuture wraps onError fallback as Success', () async {
      final result = await Result.guardFuture<String>(
        () async => throw Exception('test'),
        onError: (e, st) => 'fallback',
      );
      expect(result.isSuccess, isTrue);
      result.fold(
        (d) => expect(d, 'fallback'),
        (e) => fail('Should be Success'),
      );
    });
  });
}
