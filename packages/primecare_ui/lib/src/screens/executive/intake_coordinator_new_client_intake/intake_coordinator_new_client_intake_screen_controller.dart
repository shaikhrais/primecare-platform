import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorNewClientIntakeScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  IntakeCoordinatorNewClientIntakeScreenState({required this.isLoading, this.error, required this.data});

  IntakeCoordinatorNewClientIntakeScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return IntakeCoordinatorNewClientIntakeScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class IntakeCoordinatorNewClientIntakeScreenController extends StateNotifier<IntakeCoordinatorNewClientIntakeScreenState> {
  final Ref ref;
  IntakeCoordinatorNewClientIntakeScreenController(this.ref) : super(IntakeCoordinatorNewClientIntakeScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/intake-coordinator-new-client-intake');
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

final intake_coordinator_new_client_intakeControllerProvider = StateNotifierProvider<IntakeCoordinatorNewClientIntakeScreenController, IntakeCoordinatorNewClientIntakeScreenState>((ref) {
  return IntakeCoordinatorNewClientIntakeScreenController(ref);
});
