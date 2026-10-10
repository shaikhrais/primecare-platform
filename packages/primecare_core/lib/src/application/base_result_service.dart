import 'dart:async';
import 'package:primecare_models/primecare_models.dart';

/// Common result handling without Flutter, HTTP or native dependencies.
abstract class BaseResultService {
  Result<T> guardSync<T>(
    T Function() computation, {
    T Function(Object, StackTrace)? onError,
  }) => Result.guard<T>(computation, onError: onError);

  Future<Result<T>> guard<T>(
    FutureOr<T> Function() computation, {
    FutureOr<T> Function(Object, StackTrace)? onError,
  }) => Result.guardFuture<T>(computation, onError: onError);
}
