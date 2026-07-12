import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalOperations4KScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  ClinicalOperations4KScreenState({required this.isLoading, this.error, required this.data});

  ClinicalOperations4KScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return ClinicalOperations4KScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class ClinicalOperations4KScreenController extends StateNotifier<ClinicalOperations4KScreenState> {
  final Ref ref;
  ClinicalOperations4KScreenController(this.ref) : super(ClinicalOperations4KScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/clinical_director/operations4k');
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

final clinical_operations4_kControllerProvider = StateNotifierProvider<ClinicalOperations4KScreenController, ClinicalOperations4KScreenState>((ref) {
  return ClinicalOperations4KScreenController(ref);
});
