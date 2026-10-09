import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffingOverviewScreenState
    extends DashboardState<StaffingOverviewScreenState> {
  StaffingOverviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  StaffingOverviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => StaffingOverviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class StaffingOverviewScreenController
    extends BaseDashboardController<StaffingOverviewScreenState> {
  StaffingOverviewScreenController(Ref ref)
    : super(
        ref,
        initialState: StaffingOverviewScreenState(isLoading: true, data: {}),
        endpoint: '/executive/staffing-overview',
      );
}

final staffing_overviewControllerProvider =
    StateNotifierProvider<
      StaffingOverviewScreenController,
      StaffingOverviewScreenState
    >((ref) {
      return StaffingOverviewScreenController(ref);
    });
