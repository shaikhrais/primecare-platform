import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnComplianceScreenState
    extends DashboardState<RpnComplianceScreenState> {
  RpnComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RpnComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class RpnComplianceScreenController
    extends BaseDashboardController<RpnComplianceScreenState> {
  RpnComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-compliance',
      );
}

final rpn_complianceControllerProvider =
    StateNotifierProvider<
      RpnComplianceScreenController,
      RpnComplianceScreenState
    >((ref) {
      return RpnComplianceScreenController(ref);
    });
