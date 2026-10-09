import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswIncidentReportsScreenState
    extends DashboardState<HswIncidentReportsScreenState> {
  HswIncidentReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HswIncidentReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HswIncidentReportsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HswIncidentReportsScreenController
    extends BaseDashboardController<HswIncidentReportsScreenState> {
  HswIncidentReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: HswIncidentReportsScreenState(isLoading: true, data: {}),
        endpoint: '/clinical/hsw-incident-reports',
      );
}

final hsw_incident_reportsControllerProvider =
    StateNotifierProvider<
      HswIncidentReportsScreenController,
      HswIncidentReportsScreenState
    >((ref) {
      return HswIncidentReportsScreenController(ref);
    });
