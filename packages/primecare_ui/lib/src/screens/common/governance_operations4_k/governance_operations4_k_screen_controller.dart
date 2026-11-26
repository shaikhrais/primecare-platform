import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOperations4KScreenState
    extends DashboardState<GovernanceOperations4KScreenState> {
  GovernanceOperations4KScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  GovernanceOperations4KScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => GovernanceOperations4KScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class GovernanceOperations4KScreenController
    extends BaseDashboardController<GovernanceOperations4KScreenState> {
  GovernanceOperations4KScreenController(Ref ref)
    : super(
        ref,
        initialState: GovernanceOperations4KScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/governance-operations4-k',
      );
}

final governance_operations4_kControllerProvider =
    StateNotifierProvider<
      GovernanceOperations4KScreenController,
      GovernanceOperations4KScreenState
    >((ref) {
      return GovernanceOperations4KScreenController(ref);
    });
