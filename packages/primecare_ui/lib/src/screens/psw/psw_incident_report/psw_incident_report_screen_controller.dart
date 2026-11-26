import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportIncidentScreenState
    extends DashboardState<ReportIncidentScreenState> {
  ReportIncidentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ReportIncidentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      ReportIncidentScreenState(isLoading: isLoading, error: error, data: data);
}

class ReportIncidentScreenController
    extends BaseDashboardController<ReportIncidentScreenState> {
  ReportIncidentScreenController(Ref ref)
    : super(
        ref,
        initialState: ReportIncidentScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/incident-report',
      );
}

final psw_incident_reportControllerProvider =
    StateNotifierProvider<
      ReportIncidentScreenController,
      ReportIncidentScreenState
    >((ref) {
      return ReportIncidentScreenController(ref);
    });
