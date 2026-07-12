import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSupportAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CustomerSupportAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  CustomerSupportAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CustomerSupportAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CustomerSupportAnalyticsScreenController extends StateNotifier<CustomerSupportAnalyticsScreenState> {
  final Ref ref;
  CustomerSupportAnalyticsScreenController(this.ref) : super(CustomerSupportAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/customer-support-analytics');
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

final customer_support_analyticsControllerProvider = StateNotifierProvider<CustomerSupportAnalyticsScreenController, CustomerSupportAnalyticsScreenState>((ref) {
  return CustomerSupportAnalyticsScreenController(ref);
});
