import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffManagementScreenState
    extends DashboardState<StaffManagementScreenState> {
  StaffManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  StaffManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => StaffManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class StaffManagementScreenController
    extends BaseDashboardController<StaffManagementScreenState> {
  StaffManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: StaffManagementScreenState(isLoading: true, data: {}),
        endpoint: '/executive/staff-management',
      );
}

final staff_managementControllerProvider =
    StateNotifierProvider<
      StaffManagementScreenController,
      StaffManagementScreenState
    >((ref) {
      return StaffManagementScreenController(ref);
    });
