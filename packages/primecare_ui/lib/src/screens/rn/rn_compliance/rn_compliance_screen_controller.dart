import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnComplianceScreenState extends DashboardState<RnComplianceScreenState> {
  RnComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class RnComplianceScreenController
    extends BaseDashboardController<RnComplianceScreenState> {
  RnComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: RnComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-compliance',
      );
}

final rn_complianceControllerProvider =
    StateNotifierProvider<
      RnComplianceScreenController,
      RnComplianceScreenState
    >((ref) {
      return RnComplianceScreenController(ref);
    });
