import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooSchedulingHealthScreenState
    extends DashboardState<CooSchedulingHealthScreenState> {
  CooSchedulingHealthScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooSchedulingHealthScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooSchedulingHealthScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CooSchedulingHealthScreenController
    extends BaseDashboardController<CooSchedulingHealthScreenState> {
  CooSchedulingHealthScreenController(Ref ref)
    : super(
        ref,
        initialState: CooSchedulingHealthScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/coo/scheduling-health',
      );
}

final coo_scheduling_healthControllerProvider =
    StateNotifierProvider<
      CooSchedulingHealthScreenController,
      CooSchedulingHealthScreenState
    >((ref) {
      return CooSchedulingHealthScreenController(ref);
    });
