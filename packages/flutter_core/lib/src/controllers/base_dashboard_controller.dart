import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../network/api_client.dart';

const _retainError = Object();

/// Shared fields; concrete states retain their public feature-specific type.
abstract class DashboardState<S extends DashboardState<S>> {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;
  DashboardState({required this.isLoading, this.error, required this.data});

  S create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  });

  S copyWith({
    bool? isLoading,
    Object? error = _retainError,
    Map<String, dynamic>? data,
  }) => create(
    isLoading: isLoading ?? this.isLoading,
    error: identical(error, _retainError) ? this.error : error as String?,
    data: data ?? this.data,
  );
}

final class DashboardLoadResult {
  final bool isSuccess;
  final dynamic data;
  final String? error;
  const DashboardLoadResult({required this.isSuccess, this.data, this.error});
}

typedef DashboardLoader = Future<DashboardLoadResult> Function();

/// Shared read lifecycle. Endpoint permissions remain enforced by the backend.
abstract class BaseDashboardController<S extends DashboardState<S>>
    extends StateNotifier<S> {
  final Ref ref;
  final String endpoint;
  final DashboardLoader _loader;
  int _generation = 0;

  BaseDashboardController(
    this.ref, {
    required S initialState,
    required this.endpoint,
    DashboardLoader? loader,
  }) : _loader =
           loader ??
           (() async {
             final response = await ref.read(apiClientProvider).get(endpoint);
             return DashboardLoadResult(
               isSuccess: response.isSuccess,
               data: response.data,
               error: response.error,
             );
           }),
       super(initialState) {
    unawaited(loadDashboardData());
  }

  Future<void> loadDashboardData() async {
    if (!mounted) return;
    final generation = ++_generation;
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _loader();
      if (!mounted || generation != _generation) return;
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          error: null,
          data: responseData is Map<dynamic, dynamic>
              ? Map<String, dynamic>.from(responseData)
              : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (error) {
      if (!mounted || generation != _generation) return;
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  Future<void> syncData() => loadDashboardData();
}
