import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerAnalyticsScreenState
    extends DashboardState<OwnerAnalyticsScreenState> {
  OwnerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OwnerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      OwnerAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class OwnerAnalyticsScreenController
    extends BaseDashboardController<OwnerAnalyticsScreenState> {
  OwnerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: OwnerAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/executive/owner-analytics',
      );
}

final owner_analyticsControllerProvider =
    StateNotifierProvider<
      OwnerAnalyticsScreenController,
      OwnerAnalyticsScreenState
    >((ref) {
      return OwnerAnalyticsScreenController(ref);
    });
