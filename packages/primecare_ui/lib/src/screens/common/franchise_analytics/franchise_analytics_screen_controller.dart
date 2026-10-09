import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseAnalyticsScreenState
    extends DashboardState<FranchiseAnalyticsScreenState> {
  FranchiseAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseAnalyticsScreenController
    extends BaseDashboardController<FranchiseAnalyticsScreenState> {
  FranchiseAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/franchise-analytics',
      );
}

final franchise_analyticsControllerProvider =
    StateNotifierProvider<
      FranchiseAnalyticsScreenController,
      FranchiseAnalyticsScreenState
    >((ref) {
      return FranchiseAnalyticsScreenController(ref);
    });
