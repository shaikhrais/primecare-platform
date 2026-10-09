import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoExpensesScreenState extends DashboardState<CfoExpensesScreenState> {
  CfoExpensesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoExpensesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoExpensesScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoExpensesScreenController
    extends BaseDashboardController<CfoExpensesScreenState> {
  CfoExpensesScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoExpensesScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/cfo/expenses',
      );
}

final cfo_expensesControllerProvider =
    StateNotifierProvider<CfoExpensesScreenController, CfoExpensesScreenState>((
      ref,
    ) {
      return CfoExpensesScreenController(ref);
    });
