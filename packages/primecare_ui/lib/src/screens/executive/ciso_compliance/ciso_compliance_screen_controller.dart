import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoComplianceScreenState
    extends DashboardState<CisoComplianceScreenState> {
  CisoComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CisoComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CisoComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class CisoComplianceScreenController
    extends BaseDashboardController<CisoComplianceScreenState> {
  CisoComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CisoComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/executive/ciso-compliance',
      );
}

final ciso_complianceControllerProvider =
    StateNotifierProvider<
      CisoComplianceScreenController,
      CisoComplianceScreenState
    >((ref) {
      return CisoComplianceScreenController(ref);
    });
