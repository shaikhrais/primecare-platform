import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentReviewScreenState
    extends DashboardState<IncidentReviewScreenState> {
  IncidentReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IncidentReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      IncidentReviewScreenState(isLoading: isLoading, error: error, data: data);
}

class IncidentReviewScreenController
    extends BaseDashboardController<IncidentReviewScreenState> {
  IncidentReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: IncidentReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rn/incident-review',
      );
}

final incident_reviewControllerProvider =
    StateNotifierProvider<
      IncidentReviewScreenController,
      IncidentReviewScreenState
    >((ref) {
      return IncidentReviewScreenController(ref);
    });
