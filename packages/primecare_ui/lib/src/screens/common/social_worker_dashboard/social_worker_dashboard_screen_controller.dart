import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialWorkerDashboardScreenState
    extends DashboardState<SocialWorkerDashboardScreenState> {
  SocialWorkerDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SocialWorkerDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SocialWorkerDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SocialWorkerDashboardScreenController
    extends BaseDashboardController<SocialWorkerDashboardScreenState> {
  SocialWorkerDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: SocialWorkerDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/social_worker/dashboard',
      );
}

final social_worker_dashboardControllerProvider =
    StateNotifierProvider<
      SocialWorkerDashboardScreenController,
      SocialWorkerDashboardScreenState
    >((ref) {
      return SocialWorkerDashboardScreenController(ref);
    });
