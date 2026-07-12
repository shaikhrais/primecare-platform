import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  IntakeCoordinatorComplianceScreenState({required this.isLoading, this.error, required this.data});

  IntakeCoordinatorComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return IntakeCoordinatorComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class IntakeCoordinatorComplianceScreenController extends StateNotifier<IntakeCoordinatorComplianceScreenState> {
  final Ref ref;
  IntakeCoordinatorComplianceScreenController(this.ref) : super(IntakeCoordinatorComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/intake_coordinator/coordinator-compliance');
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

final intake_coordinator_complianceControllerProvider = StateNotifierProvider<IntakeCoordinatorComplianceScreenController, IntakeCoordinatorComplianceScreenState>((ref) {
  return IntakeCoordinatorComplianceScreenController(ref);
});
