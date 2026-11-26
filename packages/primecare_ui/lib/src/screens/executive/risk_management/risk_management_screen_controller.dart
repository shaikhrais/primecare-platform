import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiskManagementScreenState
    extends DashboardState<RiskManagementScreenState> {
  RiskManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RiskManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RiskManagementScreenState(isLoading: isLoading, error: error, data: data);
}

class RiskManagementScreenController
    extends BaseDashboardController<RiskManagementScreenState> {
  RiskManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: RiskManagementScreenState(isLoading: true, data: {}),
        endpoint: '/executive/risk-management',
      );
}

final risk_managementControllerProvider =
    StateNotifierProvider<
      RiskManagementScreenController,
      RiskManagementScreenState
    >((ref) {
      return RiskManagementScreenController(ref);
    });
