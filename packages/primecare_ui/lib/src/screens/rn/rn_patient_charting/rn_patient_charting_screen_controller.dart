import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnPatientChartingScreenState
    extends DashboardState<RnPatientChartingScreenState> {
  RnPatientChartingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnPatientChartingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnPatientChartingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RnPatientChartingScreenController
    extends BaseDashboardController<RnPatientChartingScreenState> {
  RnPatientChartingScreenController(Ref ref)
    : super(
        ref,
        initialState: RnPatientChartingScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/patient-charting',
      );
}

final rn_patient_chartingControllerProvider =
    StateNotifierProvider<
      RnPatientChartingScreenController,
      RnPatientChartingScreenState
    >((ref) {
      return RnPatientChartingScreenController(ref);
    });
