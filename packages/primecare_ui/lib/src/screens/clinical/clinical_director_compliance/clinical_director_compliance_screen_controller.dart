import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClinicalDirectorComplianceScreenState({required this.isLoading, this.error, required this.data});

  ClinicalDirectorComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClinicalDirectorComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClinicalDirectorComplianceScreenController extends StateNotifier<ClinicalDirectorComplianceScreenState> {
  final Ref ref;
  ClinicalDirectorComplianceScreenController(this.ref) : super(ClinicalDirectorComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/clinical_director/compliance-director');
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

final clinical_director_complianceControllerProvider = StateNotifierProvider<ClinicalDirectorComplianceScreenController, ClinicalDirectorComplianceScreenState>((ref) {
  return ClinicalDirectorComplianceScreenController(ref);
});
