import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnCommandCenterScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RpnCommandCenterScreenState({required this.isLoading, this.error, required this.data});

  RpnCommandCenterScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RpnCommandCenterScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RpnCommandCenterScreenController extends StateNotifier<RpnCommandCenterScreenState> {
  final Ref ref;
  RpnCommandCenterScreenController(this.ref) : super(RpnCommandCenterScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rpn/rpn-command-center');
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

final rpn_command_centerControllerProvider = StateNotifierProvider<RpnCommandCenterScreenController, RpnCommandCenterScreenState>((ref) {
  return RpnCommandCenterScreenController(ref);
});
