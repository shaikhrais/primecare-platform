import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnPatientChartingScreenState
    extends DashboardState<RpnPatientChartingScreenState> {
  RpnPatientChartingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnPatientChartingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnPatientChartingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RpnPatientChartingScreenController
    extends BaseDashboardController<RpnPatientChartingScreenState> {
  RpnPatientChartingScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnPatientChartingScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/patient-charting',
      );
}

final rpn_patient_chartingControllerProvider =
    StateNotifierProvider<
      RpnPatientChartingScreenController,
      RpnPatientChartingScreenState
    >((ref) {
      return RpnPatientChartingScreenController(ref);
    });
