part of '../result.dart';

/// Represents a failed operation.
class Failure<T> extends Result<T> {
  final Object error;
  const Failure(this.error);
}
