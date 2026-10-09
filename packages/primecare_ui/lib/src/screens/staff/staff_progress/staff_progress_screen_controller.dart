import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffProgressScreenState
    extends DashboardState<StaffProgressScreenState> {
  StaffProgressScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  StaffProgressScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      StaffProgressScreenState(isLoading: isLoading, error: error, data: data);
}

class StaffProgressScreenController
    extends BaseDashboardController<StaffProgressScreenState> {
  StaffProgressScreenController(Ref ref)
    : super(
        ref,
        initialState: StaffProgressScreenState(isLoading: true, data: {}),
        endpoint: '/staff/staff-progress',
      );
}

final staff_progressControllerProvider =
    StateNotifierProvider<
      StaffProgressScreenController,
      StaffProgressScreenState
    >((ref) {
      return StaffProgressScreenController(ref);
    });
