import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtComplianceScreenState
    extends DashboardState<RmtComplianceScreenState> {
  RmtComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RmtComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      RmtComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class RmtComplianceScreenController
    extends BaseDashboardController<RmtComplianceScreenState> {
  RmtComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: RmtComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rmt/compliance',
      );
}

final rmt_complianceControllerProvider =
    StateNotifierProvider<
      RmtComplianceScreenController,
      RmtComplianceScreenState
    >((ref) {
      return RmtComplianceScreenController(ref);
    });
