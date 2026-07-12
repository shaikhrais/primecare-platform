import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtClientIntakeScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RmtClientIntakeScreenState({required this.isLoading, this.error, required this.data});

  RmtClientIntakeScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RmtClientIntakeScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RmtClientIntakeScreenController extends StateNotifier<RmtClientIntakeScreenState> {
  final Ref ref;
  RmtClientIntakeScreenController(this.ref) : super(RmtClientIntakeScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rmt/client-intake');
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

final rmt_client_intakeControllerProvider = StateNotifierProvider<RmtClientIntakeScreenController, RmtClientIntakeScreenState>((ref) {
  return RmtClientIntakeScreenController(ref);
});
