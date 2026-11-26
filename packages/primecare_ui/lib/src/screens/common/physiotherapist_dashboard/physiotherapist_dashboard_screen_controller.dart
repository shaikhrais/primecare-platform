import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistDashboardScreenState
    extends DashboardState<PhysiotherapistDashboardScreenState> {
  PhysiotherapistDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PhysiotherapistDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PhysiotherapistDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class PhysiotherapistDashboardScreenController
    extends BaseDashboardController<PhysiotherapistDashboardScreenState> {
  PhysiotherapistDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: PhysiotherapistDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/physiotherapist/dashboard',
      );
}

final physiotherapist_dashboardControllerProvider =
    StateNotifierProvider<
      PhysiotherapistDashboardScreenController,
      PhysiotherapistDashboardScreenState
    >((ref) {
      return PhysiotherapistDashboardScreenController(ref);
    });
