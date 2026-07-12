import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CooComplianceScreenState({required this.isLoading, this.error, required this.data});

  CooComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CooComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CooComplianceScreenController extends StateNotifier<CooComplianceScreenState> {
  final Ref ref;
  CooComplianceScreenController(this.ref) : super(CooComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/corporate/roles/coo/compliance-view');
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

final coo_complianceControllerProvider = StateNotifierProvider<CooComplianceScreenController, CooComplianceScreenState>((ref) {
  return CooComplianceScreenController(ref);
});
