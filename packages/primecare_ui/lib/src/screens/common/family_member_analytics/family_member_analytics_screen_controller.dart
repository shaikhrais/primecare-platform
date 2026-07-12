import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FamilyMemberAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  FamilyMemberAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FamilyMemberAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FamilyMemberAnalyticsScreenController extends StateNotifier<FamilyMemberAnalyticsScreenState> {
  final Ref ref;
  FamilyMemberAnalyticsScreenController(this.ref) : super(FamilyMemberAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/family-member-analytics');
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

final family_member_analyticsControllerProvider = StateNotifierProvider<FamilyMemberAnalyticsScreenController, FamilyMemberAnalyticsScreenState>((ref) {
  return FamilyMemberAnalyticsScreenController(ref);
});
