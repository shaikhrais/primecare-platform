import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerComplianceScreenState
    extends DashboardState<SchedulerComplianceScreenState> {
  SchedulerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerComplianceScreenController
    extends BaseDashboardController<SchedulerComplianceScreenState> {
  SchedulerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/staff/scheduler-compliance',
      );
}

final scheduler_complianceControllerProvider =
    StateNotifierProvider<
      SchedulerComplianceScreenController,
      SchedulerComplianceScreenState
    >((ref) {
      return SchedulerComplianceScreenController(ref);
    });
