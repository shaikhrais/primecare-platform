import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistAnalyticsScreenState
    extends DashboardState<TherapistAnalyticsScreenState> {
  TherapistAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TherapistAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TherapistAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TherapistAnalyticsScreenController
    extends BaseDashboardController<TherapistAnalyticsScreenState> {
  TherapistAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: TherapistAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/therapist/analytics',
      );
}

final therapist_analyticsControllerProvider =
    StateNotifierProvider<
      TherapistAnalyticsScreenController,
      TherapistAnalyticsScreenState
    >((ref) {
      return TherapistAnalyticsScreenController(ref);
    });
