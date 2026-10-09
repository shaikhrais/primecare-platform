import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientBillingScreenState
    extends DashboardState<PatientBillingScreenState> {
  PatientBillingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PatientBillingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      PatientBillingScreenState(isLoading: isLoading, error: error, data: data);
}

class PatientBillingScreenController
    extends BaseDashboardController<PatientBillingScreenState> {
  PatientBillingScreenController(Ref ref)
    : super(
        ref,
        initialState: PatientBillingScreenState(isLoading: true, data: {}),
        endpoint: '/common/patient-billing',
      );
}

final patient_billingControllerProvider =
    StateNotifierProvider<
      PatientBillingScreenController,
      PatientBillingScreenState
    >((ref) {
      return PatientBillingScreenController(ref);
    });
