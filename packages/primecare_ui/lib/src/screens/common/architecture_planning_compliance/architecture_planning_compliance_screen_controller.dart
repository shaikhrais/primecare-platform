import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchitecturePlanningComplianceScreenState
    extends DashboardState<ArchitecturePlanningComplianceScreenState> {
  ArchitecturePlanningComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ArchitecturePlanningComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ArchitecturePlanningComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ArchitecturePlanningComplianceScreenController
    extends BaseDashboardController<ArchitecturePlanningComplianceScreenState> {
  ArchitecturePlanningComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: ArchitecturePlanningComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/architecture-planning-compliance',
      );
}

final architecture_planning_complianceControllerProvider =
    StateNotifierProvider<
      ArchitecturePlanningComplianceScreenController,
      ArchitecturePlanningComplianceScreenState
    >((ref) {
      return ArchitecturePlanningComplianceScreenController(ref);
    });
