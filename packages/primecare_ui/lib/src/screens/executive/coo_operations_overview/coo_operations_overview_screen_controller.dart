import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooOperationsOverviewScreenState
    extends DashboardState<CooOperationsOverviewScreenState> {
  CooOperationsOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooOperationsOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooOperationsOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CooOperationsOverviewScreenController
    extends BaseDashboardController<CooOperationsOverviewScreenState> {
  CooOperationsOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: CooOperationsOverviewScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/corporate/roles/coo/operations-overview',
      );
}

final coo_operations_overviewControllerProvider =
    StateNotifierProvider<
      CooOperationsOverviewScreenController,
      CooOperationsOverviewScreenState
    >((ref) {
      return CooOperationsOverviewScreenController(ref);
    });
