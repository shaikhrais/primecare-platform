import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerFinanceSnapshotScreenState
    extends DashboardState<FranchiseOwnerFinanceSnapshotScreenState> {
  FranchiseOwnerFinanceSnapshotScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerFinanceSnapshotScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerFinanceSnapshotScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerFinanceSnapshotScreenController
    extends BaseDashboardController<FranchiseOwnerFinanceSnapshotScreenState> {
  FranchiseOwnerFinanceSnapshotScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerFinanceSnapshotScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/franchise-owner-finance-snapshot',
      );
}

final franchise_owner_finance_snapshotControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerFinanceSnapshotScreenController,
      FranchiseOwnerFinanceSnapshotScreenState
    >((ref) {
      return FranchiseOwnerFinanceSnapshotScreenController(ref);
    });
