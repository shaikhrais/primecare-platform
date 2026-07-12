import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalManagerUsaComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RegionalManagerUsaComplianceScreenState({required this.isLoading, this.error, required this.data});

  RegionalManagerUsaComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RegionalManagerUsaComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RegionalManagerUsaComplianceScreenController extends StateNotifier<RegionalManagerUsaComplianceScreenState> {
  final Ref ref;
  RegionalManagerUsaComplianceScreenController(this.ref) : super(RegionalManagerUsaComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/regional-manager-usa-compliance');
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

final regional_manager_usa_complianceControllerProvider = StateNotifierProvider<RegionalManagerUsaComplianceScreenController, RegionalManagerUsaComplianceScreenState>((ref) {
  return RegionalManagerUsaComplianceScreenController(ref);
});
