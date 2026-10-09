import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOverviewScreenState
    extends DashboardState<FranchiseOverviewScreenState> {
  FranchiseOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOverviewScreenController
    extends BaseDashboardController<FranchiseOverviewScreenState> {
  FranchiseOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOverviewScreenState(isLoading: true, data: {}),
        endpoint: '/executive/franchise-overview',
      );
}

final franchise_overviewControllerProvider =
    StateNotifierProvider<
      FranchiseOverviewScreenController,
      FranchiseOverviewScreenState
    >((ref) {
      return FranchiseOverviewScreenController(ref);
    });
