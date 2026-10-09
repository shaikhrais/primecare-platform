import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayrollScreenState extends DashboardState<PayrollScreenState> {
  PayrollScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PayrollScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PayrollScreenState(isLoading: isLoading, error: error, data: data);
}

class PayrollScreenController
    extends BaseDashboardController<PayrollScreenState> {
  PayrollScreenController(Ref ref)
    : super(
        ref,
        initialState: PayrollScreenState(isLoading: true, data: {}),
        endpoint: '/executive/payroll',
      );
}

final payrollControllerProvider =
    StateNotifierProvider<PayrollScreenController, PayrollScreenState>((ref) {
      return PayrollScreenController(ref);
    });
