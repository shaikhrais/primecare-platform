import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSupportComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CustomerSupportComplianceScreenState({required this.isLoading, this.error, required this.data});

  CustomerSupportComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CustomerSupportComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CustomerSupportComplianceScreenController extends StateNotifier<CustomerSupportComplianceScreenState> {
  final Ref ref;
  CustomerSupportComplianceScreenController(this.ref) : super(CustomerSupportComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/customer-support-compliance');
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

final customer_support_complianceControllerProvider = StateNotifierProvider<CustomerSupportComplianceScreenController, CustomerSupportComplianceScreenState>((ref) {
  return CustomerSupportComplianceScreenController(ref);
});
