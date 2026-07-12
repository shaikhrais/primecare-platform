import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDevelopmentComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  BusinessDevelopmentComplianceScreenState({required this.isLoading, this.error, required this.data});

  BusinessDevelopmentComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return BusinessDevelopmentComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class BusinessDevelopmentComplianceScreenController extends StateNotifier<BusinessDevelopmentComplianceScreenState> {
  final Ref ref;
  BusinessDevelopmentComplianceScreenController(this.ref) : super(BusinessDevelopmentComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/business-development-compliance');
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

final business_development_complianceControllerProvider = StateNotifierProvider<BusinessDevelopmentComplianceScreenController, BusinessDevelopmentComplianceScreenState>((ref) {
  return BusinessDevelopmentComplianceScreenController(ref);
});
