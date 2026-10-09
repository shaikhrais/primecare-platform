import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeRecordsScreenState
    extends DashboardState<EmployeeRecordsScreenState> {
  EmployeeRecordsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  EmployeeRecordsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => EmployeeRecordsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class EmployeeRecordsScreenController
    extends BaseDashboardController<EmployeeRecordsScreenState> {
  EmployeeRecordsScreenController(Ref ref)
    : super(
        ref,
        initialState: EmployeeRecordsScreenState(isLoading: true, data: {}),
        endpoint: '/management/employee-records',
      );
}

final employee_recordsControllerProvider =
    StateNotifierProvider<
      EmployeeRecordsScreenController,
      EmployeeRecordsScreenState
    >((ref) {
      return EmployeeRecordsScreenController(ref);
    });
