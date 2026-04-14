/// Represents a deterministic result of an operation that can fail.
/// Use this to replace try-catch blocks with data-driven error handling.
sealed class Result<T> {
  final DateTime timestamp = DateTime.now();
  
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => this is Success<T> ? (this as Success<T>).data : null;
  Object? get errorOrNull => this is Failure<T> ? (this as Failure<T>).error : null;

  /// Transformation utility for result handling.
  R fold<R>(R Function(T data) onSuccess, R Function(Object error) onFailure) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      return onFailure((this as Failure<T>).error);
    }
  }

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
