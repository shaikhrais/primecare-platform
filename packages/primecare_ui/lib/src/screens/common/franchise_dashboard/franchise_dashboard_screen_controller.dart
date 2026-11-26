import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseDashboardScreenState
    extends DashboardState<FranchiseDashboardScreenState> {
  FranchiseDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseDashboardScreenController
    extends BaseDashboardController<FranchiseDashboardScreenState> {
  FranchiseDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/common/franchise-dashboard',
      );
}

final franchise_dashboardControllerProvider =
    StateNotifierProvider<
      FranchiseDashboardScreenController,
      FranchiseDashboardScreenState
    >((ref) {
      return FranchiseDashboardScreenController(ref);
    });
