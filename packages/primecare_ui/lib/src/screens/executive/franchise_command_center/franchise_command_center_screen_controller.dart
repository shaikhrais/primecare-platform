import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseCommandCenterScreenState
    extends DashboardState<FranchiseCommandCenterScreenState> {
  FranchiseCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseCommandCenterScreenController
    extends BaseDashboardController<FranchiseCommandCenterScreenState> {
  FranchiseCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/franchise-command-center',
      );
}

final franchise_command_centerControllerProvider =
    StateNotifierProvider<
      FranchiseCommandCenterScreenController,
      FranchiseCommandCenterScreenState
    >((ref) {
      return FranchiseCommandCenterScreenController(ref);
    });
