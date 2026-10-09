import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CtoComplianceScreenState
    extends DashboardState<CtoComplianceScreenState> {
  CtoComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CtoComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CtoComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class CtoComplianceScreenController
    extends BaseDashboardController<CtoComplianceScreenState> {
  CtoComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CtoComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cto-compliance',
      );
}

final cto_complianceControllerProvider =
    StateNotifierProvider<
      CtoComplianceScreenController,
      CtoComplianceScreenState
    >((ref) {
      return CtoComplianceScreenController(ref);
    });
