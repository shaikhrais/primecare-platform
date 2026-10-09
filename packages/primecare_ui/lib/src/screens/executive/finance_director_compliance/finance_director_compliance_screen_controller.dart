import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorComplianceScreenState
    extends DashboardState<FinanceDirectorComplianceScreenState> {
  FinanceDirectorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FinanceDirectorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FinanceDirectorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FinanceDirectorComplianceScreenController
    extends BaseDashboardController<FinanceDirectorComplianceScreenState> {
  FinanceDirectorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: FinanceDirectorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/finance-director-compliance',
      );
}

final finance_director_complianceControllerProvider =
    StateNotifierProvider<
      FinanceDirectorComplianceScreenController,
      FinanceDirectorComplianceScreenState
    >((ref) {
      return FinanceDirectorComplianceScreenController(ref);
    });
