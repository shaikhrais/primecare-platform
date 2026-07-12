import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingOverviewScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  BillingOverviewScreenState({required this.isLoading, this.error, required this.data});

  BillingOverviewScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return BillingOverviewScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class BillingOverviewScreenController extends StateNotifier<BillingOverviewScreenState> {
  final Ref ref;
  BillingOverviewScreenController(this.ref) : super(BillingOverviewScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/billing-overview');
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

final billing_overviewControllerProvider = StateNotifierProvider<BillingOverviewScreenController, BillingOverviewScreenState>((ref) {
  return BillingOverviewScreenController(ref);
});
