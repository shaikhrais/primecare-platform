import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  LocalMarketingManagerComplianceScreenState({required this.isLoading, this.error, required this.data});

  LocalMarketingManagerComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return LocalMarketingManagerComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class LocalMarketingManagerComplianceScreenController extends StateNotifier<LocalMarketingManagerComplianceScreenState> {
  final Ref ref;
  LocalMarketingManagerComplianceScreenController(this.ref) : super(LocalMarketingManagerComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/local-marketing-manager-compliance');
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

final local_marketing_manager_complianceControllerProvider = StateNotifierProvider<LocalMarketingManagerComplianceScreenController, LocalMarketingManagerComplianceScreenState>((ref) {
  return LocalMarketingManagerComplianceScreenController(ref);
});
