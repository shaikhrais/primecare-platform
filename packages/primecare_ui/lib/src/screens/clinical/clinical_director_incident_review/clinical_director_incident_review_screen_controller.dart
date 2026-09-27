import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorIncidentReviewScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClinicalDirectorIncidentReviewScreenState({required this.isLoading, this.error, required this.data});

  ClinicalDirectorIncidentReviewScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClinicalDirectorIncidentReviewScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClinicalDirectorIncidentReviewScreenController extends StateNotifier<ClinicalDirectorIncidentReviewScreenState> {
  final Ref ref;
  ClinicalDirectorIncidentReviewScreenController(this.ref) : super(ClinicalDirectorIncidentReviewScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/clinical_director/incident-review');
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

final clinical_director_incident_reviewControllerProvider = StateNotifierProvider<ClinicalDirectorIncidentReviewScreenController, ClinicalDirectorIncidentReviewScreenState>((ref) {
  return ClinicalDirectorIncidentReviewScreenController(ref);
});
