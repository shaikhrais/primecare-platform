import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CommunityOutreachComplianceScreenState({required this.isLoading, this.error, required this.data});

  CommunityOutreachComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CommunityOutreachComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CommunityOutreachComplianceScreenController extends StateNotifier<CommunityOutreachComplianceScreenState> {
  final Ref ref;
  CommunityOutreachComplianceScreenController(this.ref) : super(CommunityOutreachComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/community-outreach-compliance');
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

final community_outreach_complianceControllerProvider = StateNotifierProvider<CommunityOutreachComplianceScreenController, CommunityOutreachComplianceScreenState>((ref) {
  return CommunityOutreachComplianceScreenController(ref);
});
