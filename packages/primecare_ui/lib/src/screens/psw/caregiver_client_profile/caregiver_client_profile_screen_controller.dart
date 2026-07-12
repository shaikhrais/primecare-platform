import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverClientProfileScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CaregiverClientProfileScreenState({required this.isLoading, this.error, required this.data});

  CaregiverClientProfileScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CaregiverClientProfileScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CaregiverClientProfileScreenController extends StateNotifier<CaregiverClientProfileScreenState> {
  final Ref ref;
  CaregiverClientProfileScreenController(this.ref) : super(CaregiverClientProfileScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/caregiver/client-profile');
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

final caregiver_client_profileControllerProvider = StateNotifierProvider<CaregiverClientProfileScreenController, CaregiverClientProfileScreenState>((ref) {
  return CaregiverClientProfileScreenController(ref);
});
