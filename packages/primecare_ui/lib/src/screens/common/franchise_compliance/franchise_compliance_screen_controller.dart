import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseComplianceScreenState
    extends DashboardState<FranchiseComplianceScreenState> {
  FranchiseComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseComplianceScreenController
    extends BaseDashboardController<FranchiseComplianceScreenState> {
  FranchiseComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/franchise-compliance',
      );
}

final franchise_complianceControllerProvider =
    StateNotifierProvider<
      FranchiseComplianceScreenController,
      FranchiseComplianceScreenState
    >((ref) {
      return FranchiseComplianceScreenController(ref);
    });
