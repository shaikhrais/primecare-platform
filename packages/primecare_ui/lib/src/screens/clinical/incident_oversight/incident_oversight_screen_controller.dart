import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentOversightScreenState
    extends DashboardState<IncidentOversightScreenState> {
  IncidentOversightScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IncidentOversightScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IncidentOversightScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IncidentOversightScreenController
    extends BaseDashboardController<IncidentOversightScreenState> {
  IncidentOversightScreenController(Ref ref)
    : super(
        ref,
        initialState: IncidentOversightScreenState(isLoading: true, data: {}),
        endpoint:
            '/offices/clinical/roles/clinical_director/incident-oversight',
      );
}

final incident_oversightControllerProvider =
    StateNotifierProvider<
      IncidentOversightScreenController,
      IncidentOversightScreenState
    >((ref) {
      return IncidentOversightScreenController(ref);
    });
