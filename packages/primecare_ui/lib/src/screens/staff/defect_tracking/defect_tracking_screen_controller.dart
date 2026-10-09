import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefectTrackingScreenState
    extends DashboardState<DefectTrackingScreenState> {
  DefectTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  DefectTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      DefectTrackingScreenState(isLoading: isLoading, error: error, data: data);
}

class DefectTrackingScreenController
    extends BaseDashboardController<DefectTrackingScreenState> {
  DefectTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: DefectTrackingScreenState(isLoading: true, data: {}),
        endpoint: '/staff/defect-tracking',
      );
}

final defect_trackingControllerProvider =
    StateNotifierProvider<
      DefectTrackingScreenController,
      DefectTrackingScreenState
    >((ref) {
      return DefectTrackingScreenController(ref);
    });
