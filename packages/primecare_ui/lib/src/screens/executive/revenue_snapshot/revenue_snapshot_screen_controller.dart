import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevenueSnapshotScreenState
    extends DashboardState<RevenueSnapshotScreenState> {
  RevenueSnapshotScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RevenueSnapshotScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RevenueSnapshotScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RevenueSnapshotScreenController
    extends BaseDashboardController<RevenueSnapshotScreenState> {
  RevenueSnapshotScreenController(Ref ref)
    : super(
        ref,
        initialState: RevenueSnapshotScreenState(isLoading: true, data: {}),
        endpoint: '/executive/revenue-snapshot',
      );
}

final revenue_snapshotControllerProvider =
    StateNotifierProvider<
      RevenueSnapshotScreenController,
      RevenueSnapshotScreenState
    >((ref) {
      return RevenueSnapshotScreenController(ref);
    });
