import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoComplianceScreenState
    extends DashboardState<CfoComplianceScreenState> {
  CfoComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CfoComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoComplianceScreenController
    extends BaseDashboardController<CfoComplianceScreenState> {
  CfoComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cfo-compliance',
      );
}

final cfo_complianceControllerProvider =
    StateNotifierProvider<
      CfoComplianceScreenController,
      CfoComplianceScreenState
    >((ref) {
      return CfoComplianceScreenController(ref);
    });
