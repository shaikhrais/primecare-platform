import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialWorkerAnalyticsScreenState
    extends DashboardState<SocialWorkerAnalyticsScreenState> {
  SocialWorkerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SocialWorkerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SocialWorkerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SocialWorkerAnalyticsScreenController
    extends BaseDashboardController<SocialWorkerAnalyticsScreenState> {
  SocialWorkerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: SocialWorkerAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/social_worker/analytics',
      );
}

final social_worker_analyticsControllerProvider =
    StateNotifierProvider<
      SocialWorkerAnalyticsScreenController,
      SocialWorkerAnalyticsScreenState
    >((ref) {
      return SocialWorkerAnalyticsScreenController(ref);
    });
