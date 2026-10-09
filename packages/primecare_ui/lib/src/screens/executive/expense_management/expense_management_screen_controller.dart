import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseManagementScreenState
    extends DashboardState<ExpenseManagementScreenState> {
  ExpenseManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ExpenseManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ExpenseManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ExpenseManagementScreenController
    extends BaseDashboardController<ExpenseManagementScreenState> {
  ExpenseManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: ExpenseManagementScreenState(isLoading: true, data: {}),
        endpoint: '/executive/expense-management',
      );
}

final expense_managementControllerProvider =
    StateNotifierProvider<
      ExpenseManagementScreenController,
      ExpenseManagementScreenState
    >((ref) {
      return ExpenseManagementScreenController(ref);
    });
