import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  VolunteerCoordinatorComplianceScreenState({required this.isLoading, this.error, required this.data});

  VolunteerCoordinatorComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return VolunteerCoordinatorComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class VolunteerCoordinatorComplianceScreenController extends StateNotifier<VolunteerCoordinatorComplianceScreenState> {
  final Ref ref;
  VolunteerCoordinatorComplianceScreenController(this.ref) : super(VolunteerCoordinatorComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/volunteer-coordinator-compliance');
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

final volunteer_coordinator_complianceControllerProvider = StateNotifierProvider<VolunteerCoordinatorComplianceScreenController, VolunteerCoordinatorComplianceScreenState>((ref) {
  return VolunteerCoordinatorComplianceScreenController(ref);
});
