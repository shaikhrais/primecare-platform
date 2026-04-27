// Layer: 01_INFRASTRUCTURE
/// A functional return type representing either a success [S] or a failure [F].
/// Used to enforce explicit error handling across the platform.
sealed class Result<S> {
  const Result();

  /// Creates a success result.
  factory Result.success(S data) = Success<S>;

  /// Creates a failure result.
  factory Result.failure(Object error, [StackTrace? stackTrace]) = Failure<S>;

  /// Executes [onSuccess] if this is a success, or [onFailure] if it's a failure.
  T fold<T>(T Function(S data) onSuccess, T Function(Object error) onFailure);

  /// Transforms the success value [S] into a new value [T].
  Result<T> map<T>(T Function(S data) transform);

  /// Returns true if this is a success.
  bool get isSuccess;

  /// Returns true if this is a failure.
  bool get isFailure;

  /// Utility to wrap a Future in a Result, catching any errors.
  static Future<Result<T>> guardFuture<T>(
    Future<T> Function() computation, {
    T Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      final value = await computation();
      return Success(value);
    } catch (e, st) {
      if (onError != null) {
        return Success(onError(e, st));
      }
      return Failure(e, st);
    }
  }

  /// Utility to wrap a synchronous computation in a Result, catching any errors.
  static Result<T> guard<T>(
    T Function() computation, {
    T Function(Object error, StackTrace stackTrace)? onError,
  }) {
    try {
      final value = computation();
      return Success(value);
    } catch (e, st) {
      if (onError != null) {
        return Success(onError(e, st));
      }
      return Failure(e, st);
    }
  }
}

final class Success<S> extends Result<S> {
  final S data;
  const Success(this.data);

  @override
  T fold<T>(T Function(S data) onSuccess, T Function(Object error) onFailure) =>
      onSuccess(data);

  @override
  Result<T> map<T>(T Function(S data) transform) => Success(transform(data));

  @override
  bool get isSuccess => true;

  @override
  bool get isFailure => false;
}

final class Failure<S> extends Result<S> {
  final Object error;
  final StackTrace? stackTrace;

  const Failure(this.error, [this.stackTrace]);

  @override
  T fold<T>(T Function(S data) onSuccess, T Function(Object error) onFailure) =>
      onFailure(error);

  @override
  Result<T> map<T>(T Function(S data) transform) => Failure(error, stackTrace);

  @override
  bool get isSuccess => false;

  @override
  bool get isFailure => true;
}

extension ResultExtensions<S> on Result<S> {
  /// Returns the success data if this is a success, or null otherwise.
  S? get dataOrNull => fold((data) => data, (error) => null);

  /// Returns the failure error if this is a failure, or null otherwise.
  Object? get errorOrNull => fold((data) => null, (error) => error);

  /// Legacy compatibility for older adapters
  S get asSuccess => fold(
    (data) => data,
    (error) => throw StateError('Result is a failure: $error'),
  );
  Object get asFailure =>
      fold((data) => throw StateError('Result is a success'), (error) => error);
}
