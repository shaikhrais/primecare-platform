import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchitecturePlanningComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ArchitecturePlanningComplianceScreenState({required this.isLoading, this.error, required this.data});

  ArchitecturePlanningComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ArchitecturePlanningComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ArchitecturePlanningComplianceScreenController extends StateNotifier<ArchitecturePlanningComplianceScreenState> {
  final Ref ref;
  ArchitecturePlanningComplianceScreenController(this.ref) : super(ArchitecturePlanningComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/architecture-planning-compliance');
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

final architecture_planning_complianceControllerProvider = StateNotifierProvider<ArchitecturePlanningComplianceScreenController, ArchitecturePlanningComplianceScreenState>((ref) {
  return ArchitecturePlanningComplianceScreenController(ref);
});
