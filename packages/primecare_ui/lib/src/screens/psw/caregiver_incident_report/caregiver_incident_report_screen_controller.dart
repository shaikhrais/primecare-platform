import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverIncidentReportScreenState
    extends DashboardState<CaregiverIncidentReportScreenState> {
  CaregiverIncidentReportScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CaregiverIncidentReportScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CaregiverIncidentReportScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CaregiverIncidentReportScreenController
    extends BaseDashboardController<CaregiverIncidentReportScreenState> {
  CaregiverIncidentReportScreenController(Ref ref)
    : super(
        ref,
        initialState: CaregiverIncidentReportScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/caregiver/incident-report',
      );
}

final caregiver_incident_reportControllerProvider =
    StateNotifierProvider<
      CaregiverIncidentReportScreenController,
      CaregiverIncidentReportScreenState
    >((ref) {
      return CaregiverIncidentReportScreenController(ref);
    });
