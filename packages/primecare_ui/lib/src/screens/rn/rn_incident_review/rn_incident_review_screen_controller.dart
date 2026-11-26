import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnIncidentReviewScreenState
    extends DashboardState<RnIncidentReviewScreenState> {
  RnIncidentReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RnIncidentReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RnIncidentReviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class RnIncidentReviewScreenController
    extends BaseDashboardController<RnIncidentReviewScreenState> {
  RnIncidentReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: RnIncidentReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/rn-incident-review',
      );
}

final rn_incident_reviewControllerProvider =
    StateNotifierProvider<
      RnIncidentReviewScreenController,
      RnIncidentReviewScreenState
    >((ref) {
      return RnIncidentReviewScreenController(ref);
    });
