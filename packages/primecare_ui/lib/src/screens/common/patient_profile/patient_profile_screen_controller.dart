import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientProfileScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PatientProfileScreenState({required this.isLoading, this.error, required this.data});

  PatientProfileScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PatientProfileScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PatientProfileScreenController extends StateNotifier<PatientProfileScreenState> {
  final Ref ref;
  PatientProfileScreenController(this.ref) : super(PatientProfileScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/client/roles/client/profile');
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

final patient_profileControllerProvider = StateNotifierProvider<PatientProfileScreenController, PatientProfileScreenState>((ref) {
  return PatientProfileScreenController(ref);
});
