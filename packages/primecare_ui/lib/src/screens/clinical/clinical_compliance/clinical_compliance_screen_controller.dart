import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalComplianceScreenState
    extends DashboardState<ClinicalComplianceScreenState> {
  ClinicalComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalComplianceScreenController
    extends BaseDashboardController<ClinicalComplianceScreenState> {
  ClinicalComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/clinical_director/compliance',
      );
}

final clinical_complianceControllerProvider =
    StateNotifierProvider<
      ClinicalComplianceScreenController,
      ClinicalComplianceScreenState
    >((ref) {
      return ClinicalComplianceScreenController(ref);
    });
