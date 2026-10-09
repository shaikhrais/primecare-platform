import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorComplianceScreenState
    extends DashboardState<HrDirectorComplianceScreenState> {
  HrDirectorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorComplianceScreenController
    extends BaseDashboardController<HrDirectorComplianceScreenState> {
  HrDirectorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/hr-director-compliance',
      );
}

final hr_director_complianceControllerProvider =
    StateNotifierProvider<
      HrDirectorComplianceScreenController,
      HrDirectorComplianceScreenState
    >((ref) {
      return HrDirectorComplianceScreenController(ref);
    });
