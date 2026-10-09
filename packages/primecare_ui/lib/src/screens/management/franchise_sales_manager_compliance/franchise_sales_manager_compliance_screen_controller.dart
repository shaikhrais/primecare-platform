import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesManagerComplianceScreenState
    extends DashboardState<FranchiseSalesManagerComplianceScreenState> {
  FranchiseSalesManagerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseSalesManagerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseSalesManagerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseSalesManagerComplianceScreenController
    extends
        BaseDashboardController<FranchiseSalesManagerComplianceScreenState> {
  FranchiseSalesManagerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseSalesManagerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/franchise-sales-manager-compliance',
      );
}

final franchise_sales_manager_complianceControllerProvider =
    StateNotifierProvider<
      FranchiseSalesManagerComplianceScreenController,
      FranchiseSalesManagerComplianceScreenState
    >((ref) {
      return FranchiseSalesManagerComplianceScreenController(ref);
    });
