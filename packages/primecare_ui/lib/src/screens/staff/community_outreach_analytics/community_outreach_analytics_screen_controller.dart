import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachAnalyticsScreenState
    extends DashboardState<CommunityOutreachAnalyticsScreenState> {
  CommunityOutreachAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CommunityOutreachAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CommunityOutreachAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CommunityOutreachAnalyticsScreenController
    extends BaseDashboardController<CommunityOutreachAnalyticsScreenState> {
  CommunityOutreachAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CommunityOutreachAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/community-outreach-analytics',
      );
}

final community_outreach_analyticsControllerProvider =
    StateNotifierProvider<
      CommunityOutreachAnalyticsScreenController,
      CommunityOutreachAnalyticsScreenState
    >((ref) {
      return CommunityOutreachAnalyticsScreenController(ref);
    });
