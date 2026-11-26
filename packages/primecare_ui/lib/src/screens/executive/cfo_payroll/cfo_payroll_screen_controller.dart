import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoPayrollScreenState extends DashboardState<CfoPayrollScreenState> {
  CfoPayrollScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoPayrollScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoPayrollScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoPayrollScreenController
    extends BaseDashboardController<CfoPayrollScreenState> {
  CfoPayrollScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoPayrollScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/cfo/payroll',
      );
}

final cfo_payrollControllerProvider =
    StateNotifierProvider<CfoPayrollScreenController, CfoPayrollScreenState>((
      ref,
    ) {
      return CfoPayrollScreenController(ref);
    });
