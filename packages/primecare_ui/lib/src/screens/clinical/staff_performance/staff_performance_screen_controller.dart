import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffPerformanceScreenState
    extends DashboardState<StaffPerformanceScreenState> {
  StaffPerformanceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  StaffPerformanceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => StaffPerformanceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class StaffPerformanceScreenController
    extends BaseDashboardController<StaffPerformanceScreenState> {
  StaffPerformanceScreenController(Ref ref)
    : super(
        ref,
        initialState: StaffPerformanceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/staff-performance',
      );
}

final staff_performanceControllerProvider =
    StateNotifierProvider<
      StaffPerformanceScreenController,
      StaffPerformanceScreenState
    >((ref) {
      return StaffPerformanceScreenController(ref);
    });
