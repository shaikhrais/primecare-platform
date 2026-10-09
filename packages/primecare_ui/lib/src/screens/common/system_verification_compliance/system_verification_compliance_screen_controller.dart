import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SystemVerificationComplianceScreenState
    extends DashboardState<SystemVerificationComplianceScreenState> {
  SystemVerificationComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SystemVerificationComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SystemVerificationComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SystemVerificationComplianceScreenController
    extends BaseDashboardController<SystemVerificationComplianceScreenState> {
  SystemVerificationComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: SystemVerificationComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/system-verification-compliance',
      );
}

final system_verification_complianceControllerProvider =
    StateNotifierProvider<
      SystemVerificationComplianceScreenController,
      SystemVerificationComplianceScreenState
    >((ref) {
      return SystemVerificationComplianceScreenController(ref);
    });
