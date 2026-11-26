import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrumMasterAnalyticsScreenState
    extends DashboardState<ScrumMasterAnalyticsScreenState> {
  ScrumMasterAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ScrumMasterAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ScrumMasterAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ScrumMasterAnalyticsScreenController
    extends BaseDashboardController<ScrumMasterAnalyticsScreenState> {
  ScrumMasterAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ScrumMasterAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/scrum-master-analytics',
      );
}

final scrum_master_analyticsControllerProvider =
    StateNotifierProvider<
      ScrumMasterAnalyticsScreenController,
      ScrumMasterAnalyticsScreenState
    >((ref) {
      return ScrumMasterAnalyticsScreenController(ref);
    });
