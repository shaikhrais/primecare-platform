import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevAnalyticsScreenState
    extends DashboardState<HeadOfBusDevAnalyticsScreenState> {
  HeadOfBusDevAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HeadOfBusDevAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HeadOfBusDevAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HeadOfBusDevAnalyticsScreenController
    extends BaseDashboardController<HeadOfBusDevAnalyticsScreenState> {
  HeadOfBusDevAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: HeadOfBusDevAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/head-of-bus-dev-analytics',
      );
}

final head_of_bus_dev_analyticsControllerProvider =
    StateNotifierProvider<
      HeadOfBusDevAnalyticsScreenController,
      HeadOfBusDevAnalyticsScreenState
    >((ref) {
      return HeadOfBusDevAnalyticsScreenController(ref);
    });
