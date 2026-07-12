import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  IntakeComplianceScreenState({required this.isLoading, this.error, required this.data});

  IntakeComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return IntakeComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class IntakeComplianceScreenController extends StateNotifier<IntakeComplianceScreenState> {
  final Ref ref;
  IntakeComplianceScreenController(this.ref) : super(IntakeComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/intake_coordinator/compliance');
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

final intake_complianceControllerProvider = StateNotifierProvider<IntakeComplianceScreenController, IntakeComplianceScreenState>((ref) {
  return IntakeComplianceScreenController(ref);
});
