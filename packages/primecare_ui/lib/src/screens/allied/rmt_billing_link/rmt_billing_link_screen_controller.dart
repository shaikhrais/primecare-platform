import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtBillingLinkScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RmtBillingLinkScreenState({required this.isLoading, this.error, required this.data});

  RmtBillingLinkScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RmtBillingLinkScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RmtBillingLinkScreenController extends StateNotifier<RmtBillingLinkScreenState> {
  final Ref ref;
  RmtBillingLinkScreenController(this.ref) : super(RmtBillingLinkScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/rmt/billing-link');
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

final rmt_billing_linkControllerProvider = StateNotifierProvider<RmtBillingLinkScreenController, RmtBillingLinkScreenState>((ref) {
  return RmtBillingLinkScreenController(ref);
});
