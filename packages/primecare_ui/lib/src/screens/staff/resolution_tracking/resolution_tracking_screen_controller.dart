import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResolutionTrackingScreenState
    extends DashboardState<ResolutionTrackingScreenState> {
  ResolutionTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ResolutionTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ResolutionTrackingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ResolutionTrackingScreenController
    extends BaseDashboardController<ResolutionTrackingScreenState> {
  ResolutionTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: ResolutionTrackingScreenState(isLoading: true, data: {}),
        endpoint: '/staff/resolution-tracking',
      );
}

final resolution_trackingControllerProvider =
    StateNotifierProvider<
      ResolutionTrackingScreenController,
      ResolutionTrackingScreenState
    >((ref) {
      return ResolutionTrackingScreenController(ref);
    });
