import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenShiftScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  OpenShiftScreenState({required this.isLoading, this.error, required this.data});

  OpenShiftScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return OpenShiftScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class OpenShiftScreenController extends StateNotifier<OpenShiftScreenState> {
  final Ref ref;
  OpenShiftScreenController(this.ref) : super(OpenShiftScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/open-shift');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
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

final open_shiftControllerProvider = StateNotifierProvider<OpenShiftScreenController, OpenShiftScreenState>((ref) {
  return OpenShiftScreenController(ref);
});
