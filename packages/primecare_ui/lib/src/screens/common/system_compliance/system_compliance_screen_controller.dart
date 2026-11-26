import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemComplianceScreenState
    extends DashboardState<SystemComplianceScreenState> {
  SystemComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SystemComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SystemComplianceScreenController
    extends BaseDashboardController<SystemComplianceScreenState> {
  SystemComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/system-compliance',
      );
}

final system_complianceControllerProvider =
    StateNotifierProvider<
      SystemComplianceScreenController,
      SystemComplianceScreenState
    >((ref) {
      return SystemComplianceScreenController(ref);
    });
