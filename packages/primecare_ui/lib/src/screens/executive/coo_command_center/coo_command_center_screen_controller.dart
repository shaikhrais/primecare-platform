import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooCommandCenterScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CooCommandCenterScreenState({required this.isLoading, this.error, required this.data});

  CooCommandCenterScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CooCommandCenterScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CooCommandCenterScreenController extends StateNotifier<CooCommandCenterScreenState> {
  final Ref ref;
  CooCommandCenterScreenController(this.ref) : super(CooCommandCenterScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/coo-command-center');
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

final coo_command_centerControllerProvider = StateNotifierProvider<CooCommandCenterScreenController, CooCommandCenterScreenState>((ref) {
  return CooCommandCenterScreenController(ref);
});
