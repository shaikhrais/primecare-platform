import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerBranchOverviewScreenState
    extends DashboardState<FranchiseOwnerBranchOverviewScreenState> {
  FranchiseOwnerBranchOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerBranchOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerBranchOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerBranchOverviewScreenController
    extends BaseDashboardController<FranchiseOwnerBranchOverviewScreenState> {
  FranchiseOwnerBranchOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerBranchOverviewScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/franchise/roles/franchise_owner/branch-overview',
      );
}

final franchise_owner_branch_overviewControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerBranchOverviewScreenController,
      FranchiseOwnerBranchOverviewScreenState
    >((ref) {
      return FranchiseOwnerBranchOverviewScreenController(ref);
    });
