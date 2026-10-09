import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerComplianceScreenState
    extends DashboardState<HrManagerComplianceScreenState> {
  HrManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrManagerComplianceScreenController
    extends BaseDashboardController<HrManagerComplianceScreenState> {
  HrManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: HrManagerComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/staff/hr-manager-compliance',
      );
}

final hr_manager_complianceControllerProvider =
    StateNotifierProvider<
      HrManagerComplianceScreenController,
      HrManagerComplianceScreenState
    >((ref) {
      return HrManagerComplianceScreenController(ref);
    });
