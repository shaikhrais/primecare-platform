import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfMarketingComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HeadOfMarketingComplianceScreenState({required this.isLoading, this.error, required this.data});

  HeadOfMarketingComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HeadOfMarketingComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HeadOfMarketingComplianceScreenController extends StateNotifier<HeadOfMarketingComplianceScreenState> {
  final Ref ref;
  HeadOfMarketingComplianceScreenController(this.ref) : super(HeadOfMarketingComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/head-of-marketing-compliance');
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

final head_of_marketing_complianceControllerProvider = StateNotifierProvider<HeadOfMarketingComplianceScreenController, HeadOfMarketingComplianceScreenState>((ref) {
  return HeadOfMarketingComplianceScreenController(ref);
});
