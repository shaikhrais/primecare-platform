import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultNotImplementedScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  DefaultNotImplementedScreenState({required this.isLoading, this.error, required this.data});

  DefaultNotImplementedScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return DefaultNotImplementedScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class DefaultNotImplementedScreenController extends StateNotifier<DefaultNotImplementedScreenState> {
  final Ref ref;
  DefaultNotImplementedScreenController(this.ref) : super(DefaultNotImplementedScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/generated/default-not-implemented');
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          data: responseData is Map ? Map<String, dynamic>.from(responseData) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final default_not_implementedControllerProvider = StateNotifierProvider<DefaultNotImplementedScreenController, DefaultNotImplementedScreenState>((ref) {
  return DefaultNotImplementedScreenController(ref);
});
