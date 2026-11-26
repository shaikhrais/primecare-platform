import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerAnalyticsScreenState
    extends DashboardState<GeneralManagerAnalyticsScreenState> {
  GeneralManagerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GeneralManagerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GeneralManagerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GeneralManagerAnalyticsScreenController
    extends BaseDashboardController<GeneralManagerAnalyticsScreenState> {
  GeneralManagerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: GeneralManagerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/general-manager-analytics',
      );
}

final general_manager_analyticsControllerProvider =
    StateNotifierProvider<
      GeneralManagerAnalyticsScreenController,
      GeneralManagerAnalyticsScreenState
    >((ref) {
      return GeneralManagerAnalyticsScreenController(ref);
    });
