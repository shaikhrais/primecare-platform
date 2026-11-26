import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientAnalyticsScreenState
    extends DashboardState<PatientAnalyticsScreenState> {
  PatientAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PatientAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PatientAnalyticsScreenController
    extends BaseDashboardController<PatientAnalyticsScreenState> {
  PatientAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-analytics',
      );
}

final patient_analyticsControllerProvider =
    StateNotifierProvider<
      PatientAnalyticsScreenController,
      PatientAnalyticsScreenState
    >((ref) {
      return PatientAnalyticsScreenController(ref);
    });
