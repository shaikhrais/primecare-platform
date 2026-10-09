import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoCashflowScreenState extends DashboardState<CfoCashflowScreenState> {
  CfoCashflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoCashflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoCashflowScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoCashflowScreenController
    extends BaseDashboardController<CfoCashflowScreenState> {
  CfoCashflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoCashflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cfo-cashflow',
      );
}

final cfo_cashflowControllerProvider =
    StateNotifierProvider<CfoCashflowScreenController, CfoCashflowScreenState>((
      ref,
    ) {
      return CfoCashflowScreenController(ref);
    });
