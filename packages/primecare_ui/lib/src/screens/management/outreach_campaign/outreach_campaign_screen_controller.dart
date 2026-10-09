import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutreachCampaignScreenState
    extends DashboardState<OutreachCampaignScreenState> {
  OutreachCampaignScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OutreachCampaignScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OutreachCampaignScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OutreachCampaignScreenController
    extends BaseDashboardController<OutreachCampaignScreenState> {
  OutreachCampaignScreenController(Ref ref)
    : super(
        ref,
        initialState: OutreachCampaignScreenState(isLoading: true, data: {}),
        endpoint: '/management/outreach-campaign',
      );
}

final outreach_campaignControllerProvider =
    StateNotifierProvider<
      OutreachCampaignScreenController,
      OutreachCampaignScreenState
    >((ref) {
      return OutreachCampaignScreenController(ref);
    });
