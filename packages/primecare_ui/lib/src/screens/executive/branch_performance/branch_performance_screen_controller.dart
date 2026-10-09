import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BranchPerformanceScreenState
    extends DashboardState<BranchPerformanceScreenState> {
  BranchPerformanceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BranchPerformanceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BranchPerformanceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BranchPerformanceScreenController
    extends BaseDashboardController<BranchPerformanceScreenState> {
  BranchPerformanceScreenController(Ref ref)
    : super(
        ref,
        initialState: BranchPerformanceScreenState(isLoading: true, data: {}),
        endpoint: '/executive/branch-performance',
      );
}

final branch_performanceControllerProvider =
    StateNotifierProvider<
      BranchPerformanceScreenController,
      BranchPerformanceScreenState
    >((ref) {
      return BranchPerformanceScreenController(ref);
    });
