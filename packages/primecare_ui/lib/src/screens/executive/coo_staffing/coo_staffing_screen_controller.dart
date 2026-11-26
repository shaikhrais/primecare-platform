import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooStaffingScreenState extends DashboardState<CooStaffingScreenState> {
  CooStaffingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CooStaffingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CooStaffingScreenState(isLoading: isLoading, error: error, data: data);
}

class CooStaffingScreenController
    extends BaseDashboardController<CooStaffingScreenState> {
  CooStaffingScreenController(Ref ref)
    : super(
        ref,
        initialState: CooStaffingScreenState(isLoading: true, data: {}),
        endpoint: '/executive/coo-staffing',
      );
}

final coo_staffingControllerProvider =
    StateNotifierProvider<CooStaffingScreenController, CooStaffingScreenState>((
      ref,
    ) {
      return CooStaffingScreenController(ref);
    });
