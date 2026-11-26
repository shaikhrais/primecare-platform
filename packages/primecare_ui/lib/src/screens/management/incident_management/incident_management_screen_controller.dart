import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentManagementScreenState
    extends DashboardState<IncidentManagementScreenState> {
  IncidentManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IncidentManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IncidentManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IncidentManagementScreenController
    extends BaseDashboardController<IncidentManagementScreenState> {
  IncidentManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: IncidentManagementScreenState(isLoading: true, data: {}),
        endpoint: '/management/incident-management',
      );
}

final incident_managementControllerProvider =
    StateNotifierProvider<
      IncidentManagementScreenController,
      IncidentManagementScreenState
    >((ref) {
      return IncidentManagementScreenController(ref);
    });
