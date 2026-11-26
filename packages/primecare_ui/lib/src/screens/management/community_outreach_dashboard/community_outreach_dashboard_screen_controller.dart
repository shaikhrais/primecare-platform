import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachDashboardScreenState
    extends DashboardState<CommunityOutreachDashboardScreenState> {
  CommunityOutreachDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CommunityOutreachDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CommunityOutreachDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CommunityOutreachDashboardScreenController
    extends BaseDashboardController<CommunityOutreachDashboardScreenState> {
  CommunityOutreachDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: CommunityOutreachDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/marketing/roles/community_outreach/dashboard',
      );
}

final community_outreach_dashboardControllerProvider =
    StateNotifierProvider<
      CommunityOutreachDashboardScreenController,
      CommunityOutreachDashboardScreenState
    >((ref) {
      return CommunityOutreachDashboardScreenController(ref);
    });
