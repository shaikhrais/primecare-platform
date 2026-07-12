import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CisoComplianceScreenState({required this.isLoading, this.error, required this.data});

  CisoComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CisoComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CisoComplianceScreenController extends StateNotifier<CisoComplianceScreenState> {
  final Ref ref;
  CisoComplianceScreenController(this.ref) : super(CisoComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/ciso-compliance');
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

final ciso_complianceControllerProvider = StateNotifierProvider<CisoComplianceScreenController, CisoComplianceScreenState>((ref) {
  return CisoComplianceScreenController(ref);
});
