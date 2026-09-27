import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtCommandCenterScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RmtCommandCenterScreenState({required this.isLoading, this.error, required this.data});

  RmtCommandCenterScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RmtCommandCenterScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RmtCommandCenterScreenController extends StateNotifier<RmtCommandCenterScreenState> {
  final Ref ref;
  RmtCommandCenterScreenController(this.ref) : super(RmtCommandCenterScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rmt/command-center');
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

final rmt_command_centerControllerProvider = StateNotifierProvider<RmtCommandCenterScreenController, RmtCommandCenterScreenState>((ref) {
  return RmtCommandCenterScreenController(ref);
});
