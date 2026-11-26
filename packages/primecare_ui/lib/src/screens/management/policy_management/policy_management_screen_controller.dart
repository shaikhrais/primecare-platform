import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PolicyManagementScreenState
    extends DashboardState<PolicyManagementScreenState> {
  PolicyManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PolicyManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PolicyManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PolicyManagementScreenController
    extends BaseDashboardController<PolicyManagementScreenState> {
  PolicyManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: PolicyManagementScreenState(isLoading: true, data: {}),
        endpoint: '/management/policy-management',
      );
}

final policy_managementControllerProvider =
    StateNotifierProvider<
      PolicyManagementScreenController,
      PolicyManagementScreenState
    >((ref) {
      return PolicyManagementScreenController(ref);
    });
