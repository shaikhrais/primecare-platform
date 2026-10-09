import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressTrackingScreenState
    extends DashboardState<ProgressTrackingScreenState> {
  ProgressTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ProgressTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ProgressTrackingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ProgressTrackingScreenController
    extends BaseDashboardController<ProgressTrackingScreenState> {
  ProgressTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: ProgressTrackingScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/physiotherapist/progress-tracking',
      );
}

final progress_trackingControllerProvider =
    StateNotifierProvider<
      ProgressTrackingScreenController,
      ProgressTrackingScreenState
    >((ref) {
      return ProgressTrackingScreenController(ref);
    });
