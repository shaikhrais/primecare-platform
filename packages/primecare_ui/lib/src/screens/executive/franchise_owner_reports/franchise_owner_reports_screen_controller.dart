import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerReportsScreenState
    extends DashboardState<FranchiseOwnerReportsScreenState> {
  FranchiseOwnerReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerReportsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerReportsScreenController
    extends BaseDashboardController<FranchiseOwnerReportsScreenState> {
  FranchiseOwnerReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerReportsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/franchise/roles/franchise_owner/reports',
      );
}

final franchise_owner_reportsControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerReportsScreenController,
      FranchiseOwnerReportsScreenState
    >((ref) {
      return FranchiseOwnerReportsScreenController(ref);
    });
