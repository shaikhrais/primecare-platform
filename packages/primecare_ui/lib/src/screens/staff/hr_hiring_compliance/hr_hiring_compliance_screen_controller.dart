import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringComplianceScreenState
    extends DashboardState<HrHiringComplianceScreenState> {
  HrHiringComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrHiringComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrHiringComplianceScreenController
    extends BaseDashboardController<HrHiringComplianceScreenState> {
  HrHiringComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/staff/hr-hiring-compliance',
      );
}

final hr_hiring_complianceControllerProvider =
    StateNotifierProvider<
      HrHiringComplianceScreenController,
      HrHiringComplianceScreenState
    >((ref) {
      return HrHiringComplianceScreenController(ref);
    });
