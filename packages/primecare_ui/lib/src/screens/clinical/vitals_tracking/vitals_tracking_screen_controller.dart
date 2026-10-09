import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsTrackingScreenState
    extends DashboardState<VitalsTrackingScreenState> {
  VitalsTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VitalsTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      VitalsTrackingScreenState(isLoading: isLoading, error: error, data: data);
}

class VitalsTrackingScreenController
    extends BaseDashboardController<VitalsTrackingScreenState> {
  VitalsTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: VitalsTrackingScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/vitals-tracking',
      );
}

final vitals_trackingControllerProvider =
    StateNotifierProvider<
      VitalsTrackingScreenController,
      VitalsTrackingScreenState
    >((ref) {
      return VitalsTrackingScreenController(ref);
    });
