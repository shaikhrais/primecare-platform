import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ReceptionistComplianceScreenState({required this.isLoading, this.error, required this.data});

  ReceptionistComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ReceptionistComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ReceptionistComplianceScreenController extends StateNotifier<ReceptionistComplianceScreenState> {
  final Ref ref;
  ReceptionistComplianceScreenController(this.ref) : super(ReceptionistComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/receptionist-compliance');
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

final receptionist_complianceControllerProvider = StateNotifierProvider<ReceptionistComplianceScreenController, ReceptionistComplianceScreenState>((ref) {
  return ReceptionistComplianceScreenController(ref);
});
