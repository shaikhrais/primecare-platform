import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritoryExpansionManagerComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TerritoryExpansionManagerComplianceScreenState({required this.isLoading, this.error, required this.data});

  TerritoryExpansionManagerComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TerritoryExpansionManagerComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TerritoryExpansionManagerComplianceScreenController extends StateNotifier<TerritoryExpansionManagerComplianceScreenState> {
  final Ref ref;
  TerritoryExpansionManagerComplianceScreenController(this.ref) : super(TerritoryExpansionManagerComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/territory-expansion-manager-compliance');
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

final territory_expansion_manager_complianceControllerProvider = StateNotifierProvider<TerritoryExpansionManagerComplianceScreenController, TerritoryExpansionManagerComplianceScreenState>((ref) {
  return TerritoryExpansionManagerComplianceScreenController(ref);
});
