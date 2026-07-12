import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CommunityOutreachDashboardScreenState({required this.isLoading, this.error, required this.data});

  CommunityOutreachDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CommunityOutreachDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CommunityOutreachDashboardScreenController extends StateNotifier<CommunityOutreachDashboardScreenState> {
  final Ref ref;
  CommunityOutreachDashboardScreenController(this.ref) : super(CommunityOutreachDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/marketing/roles/community_outreach/dashboard');
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

final community_outreach_dashboardControllerProvider = StateNotifierProvider<CommunityOutreachDashboardScreenController, CommunityOutreachDashboardScreenState>((ref) {
  return CommunityOutreachDashboardScreenController(ref);
});
