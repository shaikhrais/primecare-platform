import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared lifecycle and updates for existing scalar Aura state controllers.
abstract class BaseValueNotifier<T> extends Notifier<T> {
  T get initialValue;
  @override
  T build() => initialValue;
  void update(covariant T value) => state = value;
}
