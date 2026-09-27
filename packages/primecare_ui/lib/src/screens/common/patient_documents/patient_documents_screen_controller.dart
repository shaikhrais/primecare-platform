import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDocumentsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PatientDocumentsScreenState({required this.isLoading, this.error, required this.data});

  PatientDocumentsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PatientDocumentsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PatientDocumentsScreenController extends StateNotifier<PatientDocumentsScreenState> {
  final Ref ref;
  PatientDocumentsScreenController(this.ref) : super(PatientDocumentsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/patient-documents');
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

final patient_documentsControllerProvider = StateNotifierProvider<PatientDocumentsScreenController, PatientDocumentsScreenState>((ref) {
  return PatientDocumentsScreenController(ref);
});
