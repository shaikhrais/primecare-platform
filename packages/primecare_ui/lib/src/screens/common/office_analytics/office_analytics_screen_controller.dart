import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeAnalyticsScreenState
    extends DashboardState<OfficeAnalyticsScreenState> {
  OfficeAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OfficeAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OfficeAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OfficeAnalyticsScreenController
    extends BaseDashboardController<OfficeAnalyticsScreenState> {
  OfficeAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: OfficeAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/office-analytics',
      );
}

final office_analyticsControllerProvider =
    StateNotifierProvider<
      OfficeAnalyticsScreenController,
      OfficeAnalyticsScreenState
    >((ref) {
      return OfficeAnalyticsScreenController(ref);
    });
