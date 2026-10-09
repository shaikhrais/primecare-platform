import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CertificationTrackingScreenState
    extends DashboardState<CertificationTrackingScreenState> {
  CertificationTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CertificationTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CertificationTrackingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CertificationTrackingScreenController
    extends BaseDashboardController<CertificationTrackingScreenState> {
  CertificationTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: CertificationTrackingScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/certification-tracking',
      );
}

final certification_trackingControllerProvider =
    StateNotifierProvider<
      CertificationTrackingScreenController,
      CertificationTrackingScreenState
    >((ref) {
      return CertificationTrackingScreenController(ref);
    });
