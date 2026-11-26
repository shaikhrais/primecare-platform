import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseOwnerComplianceScreenState
    extends DashboardState<FranchiseOwnerComplianceScreenState> {
  FranchiseOwnerComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FranchiseOwnerComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FranchiseOwnerComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FranchiseOwnerComplianceScreenController
    extends BaseDashboardController<FranchiseOwnerComplianceScreenState> {
  FranchiseOwnerComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: FranchiseOwnerComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/franchise/roles/franchise_owner/compliance',
      );
}

final franchise_owner_complianceControllerProvider =
    StateNotifierProvider<
      FranchiseOwnerComplianceScreenController,
      FranchiseOwnerComplianceScreenState
    >((ref) {
      return FranchiseOwnerComplianceScreenController(ref);
    });
