import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QualityAssuranceComplianceScreenState
    extends DashboardState<QualityAssuranceComplianceScreenState> {
  QualityAssuranceComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QualityAssuranceComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QualityAssuranceComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class QualityAssuranceComplianceScreenController
    extends BaseDashboardController<QualityAssuranceComplianceScreenState> {
  QualityAssuranceComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: QualityAssuranceComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/quality-assurance-compliance',
      );
}

final quality_assurance_complianceControllerProvider =
    StateNotifierProvider<
      QualityAssuranceComplianceScreenController,
      QualityAssuranceComplianceScreenState
    >((ref) {
      return QualityAssuranceComplianceScreenController(ref);
    });
