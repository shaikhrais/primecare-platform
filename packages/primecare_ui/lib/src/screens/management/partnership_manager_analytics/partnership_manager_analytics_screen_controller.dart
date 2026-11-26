import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerAnalyticsScreenState
    extends DashboardState<PartnershipManagerAnalyticsScreenState> {
  PartnershipManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PartnershipManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PartnershipManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PartnershipManagerAnalyticsScreenController
    extends BaseDashboardController<PartnershipManagerAnalyticsScreenState> {
  PartnershipManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PartnershipManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/partnership-manager-analytics',
      );
}

final partnership_manager_analyticsControllerProvider =
    StateNotifierProvider<
      PartnershipManagerAnalyticsScreenController,
      PartnershipManagerAnalyticsScreenState
    >((ref) {
      return PartnershipManagerAnalyticsScreenController(ref);
    });
