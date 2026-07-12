import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CxDirectorComplianceScreenState({required this.isLoading, this.error, required this.data});

  CxDirectorComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CxDirectorComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CxDirectorComplianceScreenController extends StateNotifier<CxDirectorComplianceScreenState> {
  final Ref ref;
  CxDirectorComplianceScreenController(this.ref) : super(CxDirectorComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/cx-director-compliance');
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

final cx_director_complianceControllerProvider = StateNotifierProvider<CxDirectorComplianceScreenController, CxDirectorComplianceScreenState>((ref) {
  return CxDirectorComplianceScreenController(ref);
});
