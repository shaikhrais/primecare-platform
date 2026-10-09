import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorComplianceScreenState
    extends DashboardState<ClinicalDirectorComplianceScreenState> {
  ClinicalDirectorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalDirectorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalDirectorComplianceScreenController
    extends BaseDashboardController<ClinicalDirectorComplianceScreenState> {
  ClinicalDirectorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalDirectorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/clinical/roles/clinical_director/compliance-director',
      );
}

final clinical_director_complianceControllerProvider =
    StateNotifierProvider<
      ClinicalDirectorComplianceScreenController,
      ClinicalDirectorComplianceScreenState
    >((ref) {
      return ClinicalDirectorComplianceScreenController(ref);
    });
