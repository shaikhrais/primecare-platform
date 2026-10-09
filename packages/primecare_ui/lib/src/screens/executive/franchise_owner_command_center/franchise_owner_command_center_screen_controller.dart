import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerCommandCenterScreenState
    extends DashboardState<FranchiseOwnerCommandCenterScreenState> {
  FranchiseOwnerCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerCommandCenterScreenController
    extends BaseDashboardController<FranchiseOwnerCommandCenterScreenState> {
  FranchiseOwnerCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/franchise-owner-command-center',
      );
}

final franchise_owner_command_centerControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerCommandCenterScreenController,
      FranchiseOwnerCommandCenterScreenState
    >((ref) {
      return FranchiseOwnerCommandCenterScreenController(ref);
    });
