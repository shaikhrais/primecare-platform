import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooBranchComparisonScreenState
    extends DashboardState<CooBranchComparisonScreenState> {
  CooBranchComparisonScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooBranchComparisonScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooBranchComparisonScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CooBranchComparisonScreenController
    extends BaseDashboardController<CooBranchComparisonScreenState> {
  CooBranchComparisonScreenController(Ref ref)
    : super(
        ref,
        initialState: CooBranchComparisonScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/coo/branch-comparison',
      );
}

final coo_branch_comparisonControllerProvider =
    StateNotifierProvider<
      CooBranchComparisonScreenController,
      CooBranchComparisonScreenState
    >((ref) {
      return CooBranchComparisonScreenController(ref);
    });
