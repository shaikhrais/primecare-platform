import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnIncidentReviewScreenState
    extends DashboardState<RpnIncidentReviewScreenState> {
  RpnIncidentReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RpnIncidentReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RpnIncidentReviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RpnIncidentReviewScreenController
    extends BaseDashboardController<RpnIncidentReviewScreenState> {
  RpnIncidentReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: RpnIncidentReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/rpn-incident-review',
      );
}

final rpn_incident_reviewControllerProvider =
    StateNotifierProvider<
      RpnIncidentReviewScreenController,
      RpnIncidentReviewScreenState
    >((ref) {
      return RpnIncidentReviewScreenController(ref);
    });
