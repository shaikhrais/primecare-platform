import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PartnershipManagerDashboardScreenState({required this.isLoading, this.error, required this.data});

  PartnershipManagerDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PartnershipManagerDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PartnershipManagerDashboardScreenController extends StateNotifier<PartnershipManagerDashboardScreenState> {
  final Ref ref;
  PartnershipManagerDashboardScreenController(this.ref) : super(PartnershipManagerDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/business_development/roles/partnership_manager/dashboard');
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

final partnership_manager_dashboardControllerProvider = StateNotifierProvider<PartnershipManagerDashboardScreenController, PartnershipManagerDashboardScreenState>((ref) {
  return PartnershipManagerDashboardScreenController(ref);
});
