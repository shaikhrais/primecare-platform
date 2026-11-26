import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumConciergeCareCoordinatorAnalyticsScreenState
    extends
        DashboardState<PremiumConciergeCareCoordinatorAnalyticsScreenState> {
  PremiumConciergeCareCoordinatorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PremiumConciergeCareCoordinatorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PremiumConciergeCareCoordinatorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PremiumConciergeCareCoordinatorAnalyticsScreenController
    extends
        BaseDashboardController<
          PremiumConciergeCareCoordinatorAnalyticsScreenState
        > {
  PremiumConciergeCareCoordinatorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PremiumConciergeCareCoordinatorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/premium/premium-concierge-analytics',
      );
}

final premium_concierge_analyticsControllerProvider =
    StateNotifierProvider<
      PremiumConciergeCareCoordinatorAnalyticsScreenController,
      PremiumConciergeCareCoordinatorAnalyticsScreenState
    >((ref) {
      return PremiumConciergeCareCoordinatorAnalyticsScreenController(ref);
    });
