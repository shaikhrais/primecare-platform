import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorIncidentReviewScreenState
    extends DashboardState<ClinicalDirectorIncidentReviewScreenState> {
  ClinicalDirectorIncidentReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClinicalDirectorIncidentReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorIncidentReviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ClinicalDirectorIncidentReviewScreenController
    extends BaseDashboardController<ClinicalDirectorIncidentReviewScreenState> {
  ClinicalDirectorIncidentReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: ClinicalDirectorIncidentReviewScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/clinical_director/incident-review',
      );
}

final clinical_director_incident_reviewControllerProvider =
    StateNotifierProvider<
      ClinicalDirectorIncidentReviewScreenController,
      ClinicalDirectorIncidentReviewScreenState
    >((ref) {
      return ClinicalDirectorIncidentReviewScreenController(ref);
    });
