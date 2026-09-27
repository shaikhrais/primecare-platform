import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorTreatmentNotesScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ChiropractorTreatmentNotesScreenState({required this.isLoading, this.error, required this.data});

  ChiropractorTreatmentNotesScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ChiropractorTreatmentNotesScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ChiropractorTreatmentNotesScreenController extends StateNotifier<ChiropractorTreatmentNotesScreenState> {
  final Ref ref;
  ChiropractorTreatmentNotesScreenController(this.ref) : super(ChiropractorTreatmentNotesScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/chiropractor/treatment-notes');
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

final chiropractor_treatment_notesControllerProvider = StateNotifierProvider<ChiropractorTreatmentNotesScreenController, ChiropractorTreatmentNotesScreenState>((ref) {
  return ChiropractorTreatmentNotesScreenController(ref);
});
