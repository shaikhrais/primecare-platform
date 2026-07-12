import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorStaffQualityScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClinicalDirectorStaffQualityScreenState({required this.isLoading, this.error, required this.data});

  ClinicalDirectorStaffQualityScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClinicalDirectorStaffQualityScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClinicalDirectorStaffQualityScreenController extends StateNotifier<ClinicalDirectorStaffQualityScreenState> {
  final Ref ref;
  ClinicalDirectorStaffQualityScreenController(this.ref) : super(ClinicalDirectorStaffQualityScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/clinical_director/staff-quality');
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

final clinical_director_staff_qualityControllerProvider = StateNotifierProvider<ClinicalDirectorStaffQualityScreenController, ClinicalDirectorStaffQualityScreenState>((ref) {
  return ClinicalDirectorStaffQualityScreenController(ref);
});
