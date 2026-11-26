import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialWorkerComplianceScreenState
    extends DashboardState<SocialWorkerComplianceScreenState> {
  SocialWorkerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SocialWorkerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SocialWorkerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SocialWorkerComplianceScreenController
    extends BaseDashboardController<SocialWorkerComplianceScreenState> {
  SocialWorkerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: SocialWorkerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/social_worker/compliance',
      );
}

final social_worker_complianceControllerProvider =
    StateNotifierProvider<
      SocialWorkerComplianceScreenController,
      SocialWorkerComplianceScreenState
    >((ref) {
      return SocialWorkerComplianceScreenController(ref);
    });
