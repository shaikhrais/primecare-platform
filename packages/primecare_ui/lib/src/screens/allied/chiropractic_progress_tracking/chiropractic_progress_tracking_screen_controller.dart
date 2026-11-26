import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropracticProgressTrackingScreenState
    extends DashboardState<ChiropracticProgressTrackingScreenState> {
  ChiropracticProgressTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropracticProgressTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropracticProgressTrackingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropracticProgressTrackingScreenController
    extends BaseDashboardController<ChiropracticProgressTrackingScreenState> {
  ChiropracticProgressTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropracticProgressTrackingScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint:
            '/offices/clinical/roles/chiropractor/chiropractic-progress-tracking',
      );
}

final chiropractic_progress_trackingControllerProvider =
    StateNotifierProvider<
      ChiropracticProgressTrackingScreenController,
      ChiropracticProgressTrackingScreenState
    >((ref) {
      return ChiropracticProgressTrackingScreenController(ref);
    });
