import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureComplianceScreenState
    extends DashboardState<InfrastructureComplianceScreenState> {
  InfrastructureComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  InfrastructureComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => InfrastructureComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class InfrastructureComplianceScreenController
    extends BaseDashboardController<InfrastructureComplianceScreenState> {
  InfrastructureComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: InfrastructureComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/infrastructure-compliance',
      );
}

final infrastructure_complianceControllerProvider =
    StateNotifierProvider<
      InfrastructureComplianceScreenController,
      InfrastructureComplianceScreenState
    >((ref) {
      return InfrastructureComplianceScreenController(ref);
    });
