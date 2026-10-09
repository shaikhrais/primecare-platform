import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseCommandCenter4KScreenState
    extends DashboardState<FranchiseCommandCenter4KScreenState> {
  FranchiseCommandCenter4KScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseCommandCenter4KScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseCommandCenter4KScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseCommandCenter4KScreenController
    extends BaseDashboardController<FranchiseCommandCenter4KScreenState> {
  FranchiseCommandCenter4KScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseCommandCenter4KScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/franchise-command-center4-k',
      );
}

final franchise_command_center4_kControllerProvider =
    StateNotifierProvider<
      FranchiseCommandCenter4KScreenController,
      FranchiseCommandCenter4KScreenState
    >((ref) {
      return FranchiseCommandCenter4KScreenController(ref);
    });
