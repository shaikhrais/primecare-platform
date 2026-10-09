import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerComplianceScreenState
    extends DashboardState<OperationsManagerComplianceScreenState> {
  OperationsManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OperationsManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OperationsManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OperationsManagerComplianceScreenController
    extends BaseDashboardController<OperationsManagerComplianceScreenState> {
  OperationsManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: OperationsManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/operations-manager-compliance',
      );
}

final operations_manager_complianceControllerProvider =
    StateNotifierProvider<
      OperationsManagerComplianceScreenController,
      OperationsManagerComplianceScreenState
    >((ref) {
      return OperationsManagerComplianceScreenController(ref);
    });
