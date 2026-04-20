/// Represents a deterministic result of an operation that can fail.
/// Use this to replace try-catch blocks with data-driven error handling.
sealed class Result<T> {
  final DateTime timestamp = DateTime.now();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;
  Object? get errorOrNull =>
      this is Failure<T> ? (this as Failure<T>).error : null;

  /// Transformation utility for result handling.
  R fold<R>(R Function(T data) onSuccess, R Function(Object error) onFailure) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onFailure((this as Failure<T>).error);
    }
  }

  /// Maps the success value to a new type.
  /// If the result is a failure, it returns a new failure of the same type.
  Result<R> map<R>(R Function(T data) transform) {
    if (this is Success<T>) {
      return Result.success(
        transform((this as Success<T>).data),
        metadata: (this as Success<T>).metadata,
      );
    } else {
      final failure = this as Failure<T>;
      return Result.failure<R>(
        failure.error,
        stackTrace: failure.stackTrace,
        message: failure.message,
        metadata: failure.metadata,
      );
    }
  }

  /// Exhaustive pattern matching for result handling.
  R when<R>({
    required R Function(T data, Map<String, dynamic>? metadata) success,
    required R Function(
      Object error,
      StackTrace? stackTrace,
      String? message,
      Map<String, dynamic>? metadata,
    )
    failure,
  }) {
    if (this is Success<T>) {
      final s = this as Success<T>;
      return success(s.data, s.metadata);
    } else {
      final f = this as Failure<T>;
      return failure(f.error, f.stackTrace, f.message, f.metadata);
    }
  }

  /// Factory for a successful result.
  static Result<T> success<T>(T data, {Map<String, dynamic>? metadata}) =>
      Success<T>(data, metadata: metadata);

  /// Factory for a failed result.
  static Result<T> failure<T>(
    Object error, {
    StackTrace? stackTrace,
    String? message,
    Map<String, dynamic>? metadata,
  }) => Failure<T>(
    error,
    stackTrace: stackTrace,
    message: message,
    metadata: metadata,
  );

  /// Deterministically guards a future operation and executes an optional
  /// recovery block (e.g., LKG restoration) on failure.
  static Future<Result<T>> guardFuture<T>(
    Future<T> Function() computation, {
    T Function(Object error, StackTrace)? onError,
  }) async {
    try {
      final data = await computation();
      return Success<T>(data);
    } catch (e, st) {
      if (onError != null) {
        try {
          final recoveredData = onError(e, st);
          return Success<T>(recoveredData);
        } catch (recoveryError, recoverySt) {
          return Failure<T>(
            recoveryError,
            stackTrace: recoverySt,
            message: 'Primary computation and recovery both failed',
          );
        }
      }
      return Failure<T>(e, stackTrace: st);
    }
  }

  /// Deterministically guards a synchronous operation and executes an optional
  /// recovery block (e.g., LKG restoration) on failure.
  static Result<T> guard<T>(
    T Function() computation, {
    T Function(Object error, StackTrace)? onError,
  }) {
    try {
      final data = computation();
      return Success<T>(data);
    } catch (e, st) {
      if (onError != null) {
        try {
          final recoveredData = onError(e, st);
          return Success<T>(recoveredData);
        } catch (recoveryError, recoverySt) {
          return Failure<T>(
            recoveryError,
            stackTrace: recoverySt,
            message: 'Primary computation and recovery both failed',
          );
        }
      }
      return Failure<T>(e, stackTrace: st);
    }
  }
}

class Success<T> extends Result<T> {
  final T data;
  final Map<String, dynamic>? metadata;

  Success(this.data, {this.metadata});
}

class Failure<T> extends Result<T> {
  final Object error;
  final StackTrace? stackTrace;
  final String? message;
  final Map<String, dynamic>? metadata;

  Failure(this.error, {this.stackTrace, this.message, this.metadata});
}
