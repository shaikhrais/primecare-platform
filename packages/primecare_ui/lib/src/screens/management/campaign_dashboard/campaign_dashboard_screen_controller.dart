import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CampaignDashboardScreenState
    extends DashboardState<CampaignDashboardScreenState> {
  CampaignDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CampaignDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CampaignDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CampaignDashboardScreenController
    extends BaseDashboardController<CampaignDashboardScreenState> {
  CampaignDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: CampaignDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/management/campaign-dashboard',
      );
}

final campaign_dashboardControllerProvider =
    StateNotifierProvider<
      CampaignDashboardScreenController,
      CampaignDashboardScreenState
    >((ref) {
      return CampaignDashboardScreenController(ref);
    });
