part of '../result.dart';

/// Represents a successful operation.
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
