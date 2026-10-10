// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE A sealed class representing the result of an operation that can either succeed with a value ...
// Layer: 01_INFRASTRUCTURE
import 'dart:async';

/// A sealed class representing the result of an operation that can either
/// succeed with a value of type [T] or fail with an error.
sealed class Result<T> {
  const Result();

  /// Executes a function and wraps the result in a [Result].
  static Result<T> guard<T>(
    T Function() computation, {
    T Function(Object error, StackTrace stackTrace)? onError,
  }) {
    try {
      return Success(computation());
    } catch (e, st) {
      if (onError != null) {
        try {
          return Success(onError(e, st));
        } catch (innerError) {
          return Failure(innerError);
        }
      }
      return Failure(e);
    }
  }

  /// Executes a future and wraps the result in a [Result].
  /// Provides a standardized way to handle errors and resilience.
  static Future<Result<T>> guardFuture<T>(
    FutureOr<T> Function() computation, {
    FutureOr<T> Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      final value = await computation();
      return Success(value);
    } catch (e, st) {
      if (onError != null) {
        try {
          final fallbackValue = await onError(e, st);
          return Success(fallbackValue);
        } catch (innerError) {
          return Failure(innerError);
        }
      }
      return Failure(e);
    }
  }

  /// Transforms the [Result] using the provided functions.
  R fold<R>(R Function(T data) onSuccess, R Function(Object error) onFailure) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onFailure((this as Failure<T>).error);
    }
  }

  /// Returns the data if the result is a [Success], otherwise throws the error.
  T getOrThrow() {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    } else {
      throw (this as Failure<T>).error;
    }
  }
}

/// Represents a successful operation.
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Represents a failed operation.
class Failure<T> extends Result<T> {
  final Object error;
  const Failure(this.error);
}
