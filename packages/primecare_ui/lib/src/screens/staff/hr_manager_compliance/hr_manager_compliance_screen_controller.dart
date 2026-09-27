import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HrManagerComplianceScreenState({required this.isLoading, this.error, required this.data});

  HrManagerComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HrManagerComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HrManagerComplianceScreenController extends StateNotifier<HrManagerComplianceScreenState> {
  final Ref ref;
  HrManagerComplianceScreenController(this.ref) : super(HrManagerComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/hr-manager-compliance');
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

final hr_manager_complianceControllerProvider = StateNotifierProvider<HrManagerComplianceScreenController, HrManagerComplianceScreenState>((ref) {
  return HrManagerComplianceScreenController(ref);
});
