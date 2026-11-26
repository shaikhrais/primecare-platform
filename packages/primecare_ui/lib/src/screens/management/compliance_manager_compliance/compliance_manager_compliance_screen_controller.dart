import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerComplianceScreenState
    extends DashboardState<ComplianceManagerComplianceScreenState> {
  ComplianceManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ComplianceManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ComplianceManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ComplianceManagerComplianceScreenController
    extends BaseDashboardController<ComplianceManagerComplianceScreenState> {
  ComplianceManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ComplianceManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/compliance-manager-compliance',
      );
}

final compliance_manager_complianceControllerProvider =
    StateNotifierProvider<
      ComplianceManagerComplianceScreenController,
      ComplianceManagerComplianceScreenState
    >((ref) {
      return ComplianceManagerComplianceScreenController(ref);
    });
