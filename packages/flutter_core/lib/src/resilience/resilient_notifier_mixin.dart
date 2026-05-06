// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'dart:async';

mixin ResilientNotifierMixin<S> on Notifier<S> {
  Future<void> guardHydration<T>({
    required Future<Result<T>> Function() fetch,
    required S Function(T data) onSuccess,
    required S Function(String message) onError,
    required S loadingState,
    ExecutionGateCategory category = ExecutionGateCategory.domainApi,
  }) async {
    state = loadingState;
    try {
      final result = await fetch();
      state = result.fold(
        (data) => onSuccess(data),
        (error) => onError(error.toString()),
      );
    } catch (e) {
      state = onError(e.toString());
    }
  }
}
