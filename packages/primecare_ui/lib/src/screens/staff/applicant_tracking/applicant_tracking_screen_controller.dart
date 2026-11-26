import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicantTrackingScreenState
    extends DashboardState<ApplicantTrackingScreenState> {
  ApplicantTrackingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ApplicantTrackingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ApplicantTrackingScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ApplicantTrackingScreenController
    extends BaseDashboardController<ApplicantTrackingScreenState> {
  ApplicantTrackingScreenController(Ref ref)
    : super(
        ref,
        initialState: ApplicantTrackingScreenState(isLoading: true, data: {}),
        endpoint: '/staff/applicant-tracking',
      );
}

final applicant_trackingControllerProvider =
    StateNotifierProvider<
      ApplicantTrackingScreenController,
      ApplicantTrackingScreenState
    >((ref) {
      return ApplicantTrackingScreenController(ref);
    });
