import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumConciergeDashboardScreenState
    extends DashboardState<PremiumConciergeDashboardScreenState> {
  PremiumConciergeDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PremiumConciergeDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PremiumConciergeDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PremiumConciergeDashboardScreenController
    extends BaseDashboardController<PremiumConciergeDashboardScreenState> {
  PremiumConciergeDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: PremiumConciergeDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/premium-concierge-dashboard',
      );
}

final premium_concierge_dashboardControllerProvider =
    StateNotifierProvider<
      PremiumConciergeDashboardScreenController,
      PremiumConciergeDashboardScreenState
    >((ref) {
      return PremiumConciergeDashboardScreenController(ref);
    });
