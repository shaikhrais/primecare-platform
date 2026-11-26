import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinancialOperations4KScreenState
    extends DashboardState<FinancialOperations4KScreenState> {
  FinancialOperations4KScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FinancialOperations4KScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FinancialOperations4KScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FinancialOperations4KScreenController
    extends BaseDashboardController<FinancialOperations4KScreenState> {
  FinancialOperations4KScreenController(Ref ref)
    : super(
        ref,
        initialState: FinancialOperations4KScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/financial-operations4-k',
      );
}

final financial_operations4_kControllerProvider =
    StateNotifierProvider<
      FinancialOperations4KScreenController,
      FinancialOperations4KScreenState
    >((ref) {
      return FinancialOperations4KScreenController(ref);
    });
