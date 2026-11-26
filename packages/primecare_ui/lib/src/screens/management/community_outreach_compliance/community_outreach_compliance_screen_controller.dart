import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityOutreachComplianceScreenState
    extends DashboardState<CommunityOutreachComplianceScreenState> {
  CommunityOutreachComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CommunityOutreachComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CommunityOutreachComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CommunityOutreachComplianceScreenController
    extends BaseDashboardController<CommunityOutreachComplianceScreenState> {
  CommunityOutreachComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CommunityOutreachComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/community-outreach-compliance',
      );
}

final community_outreach_complianceControllerProvider =
    StateNotifierProvider<
      CommunityOutreachComplianceScreenController,
      CommunityOutreachComplianceScreenState
    >((ref) {
      return CommunityOutreachComplianceScreenController(ref);
    });
