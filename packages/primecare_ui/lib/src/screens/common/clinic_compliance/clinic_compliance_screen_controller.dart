import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicComplianceScreenState
    extends DashboardState<ClinicComplianceScreenState> {
  ClinicComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicComplianceScreenController
    extends BaseDashboardController<ClinicComplianceScreenState> {
  ClinicComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/clinic-compliance',
      );
}

final clinic_complianceControllerProvider =
    StateNotifierProvider<
      ClinicComplianceScreenController,
      ClinicComplianceScreenState
    >((ref) {
      return ClinicComplianceScreenController(ref);
    });
